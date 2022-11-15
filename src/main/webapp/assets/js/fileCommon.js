/**
 * Drag&Drop File namespace
 * 2018-03-29 정언구
 */
var DDFC = DDFC || function($){
	return DragAndDropFile($);
}(jQuery);

/*
 * 드랍존 삭제버튼 추가
 * */
var dz_delete_button = '<button type="button" class="btn btn-danger btn-xs dz-delete-btn "><span class="glyphicon glyphicon-trash"></span> 삭제 </button>';

/**
 * 드래그 앤 드랍 파일 정의 시작
 */
function DragAndDropFile($){

	$.Event("emptyDropzone", { target : this } ); //드랍존 초기화 이벤트
	$.Event("getFiles", { target : this } ); //파일 호출 이벤트
    $.Event("deleteFileEvent", { target : this } ); //파일 삭제 이벤트
    $.Event("uploadComplete", { target : this }); //업로드 완료 이벤트
    $.Event("uploadClick", { target : this }); //업로드 트리거 이벤트

	var $DZID = null; //드랍존 Object를 담을 변수
	var fileGetting = false; //파일 중복 호출 방지 플래그 변수
	var formData = new FormData(); //업로드 시 사용할 폼데이터 선언
	var files = new Array(); //업로드 전까지 파일 객체를 담을 배열
	var ordArr = new Array(); //현재 정렬 순서를 저장할 배열
	// lock : 드랍존 사용 불가 여부, clear : 파일 업로드 시도했을 때 드랍존 초기화 할지, msg : 사용 불가 상태에서 업로드 시도할 때 띄울 메세지
	var lockFlag = { lock : false, clear : true, msg : "선택된 항목이 없습니다."  };
	var uploadFlag = false; // 업로드 실행여부 ( true : 업로드 실행, false : 업로드 실행 취소 )
	var readOnlyFlag = false; //드랍존 읽기 모드 설정 ( 읽기 모드 : 다운로드만 가능)
	var revision = false; //개정 모드
	var fileCount = 0;		//업로드 된 파일 개수
	var deleteButtonYn = 'Y';	//삭제버튼 숨기기(N:미사용,Y:사용 )

    function bind(){ return DragAndDropFile($); };
	function initFormData(){ formData = new FormData();	};
	function initFiles(){ files = new Array(); };
	function initOrdArr(){ ordArr = new Array(); };
	function getNewFiles(){ return files; };
	function getOrdArr(){ return ordArr; };
	function getFileIdx(){ return $DZID.find("#fileIdx").val(); };

	function setRevision(val){
		revision = val;
	}

	function setFileIdx(fileIdx){ $DZID.find("#fileIdx").val(fileIdx); return this; };
	/**
	 * @param lock 인자없이 호출하거나 true를 주면 사용 불가, false를 주면 드랍존 사용가능
	 * ( getFiles 함수 호출 시 자동적으로 false선언, 임의로 드랍존 사용 여부를 조절하고 싶다면 해당 함수 사용,
	 *   readOnly와 다름 )
	 * @param clear 드랍존을 청소할 지 ( 드랍존 사용 불가일 때 업로드를 시도한 후 )
	 * @param msg 사용 불가 처리시 메시지를 띄우려면 작성 ( 드랍존에 업로드를 시도할 때 띄울 메세지 )
	 */
	function lock(lock, clear, msg){
		lockFlag.lock = lock == undefined ? true : lock;
		lockFlag.clear = clear == undefined ? true : clear;
		lockFlag.msg = msg == undefined ? "선택된 항목이 없습니다." : msg;

		return this;
		};
	/**
	 * 인자를 넣지 않거나 true를 주면 업로드 수행 허용, false면 업로드 수행 불가
	 */
	function upload(flag){ uploadFlag = flag == undefined ? true : flag; return this; };
	/**
	 * 드랍존 readOnly 처리
	 */
	function readOnly(flag){
		readOnlyFlag = flag;
	};

	function setFiles(file){
		files.push(file);
	}
	function setFormData(keyName, param){
		if($.isArray(param)){
			for(var i = 0 ; i<param.length; i++)
				formData.append(keyName, param[i]);
		}else
			formData.append(keyName, param);
	}
	function setOrdArr( fileNm, uuid, ord ){
		ordArr.push({ "fileNm" : fileNm, "uuid" : uuid, "ord" : ord });
	}
	function deleteOrdArr( uuid ){
		for(var i = 0 ; i<ordArr.length; i++){
			if( uuid == ordArr[i].uuid ){
				ordArr.splice(i,1);
				break;
			}
		}
	}
	function deleteFiles(uuid){
		var files = getNewFiles();
		for(var i = 0 ; i<files.length; i++){
			if( uuid == files[i].upload.uuid ){
				files.splice(i, 1);
				break;
			}
		}
	}
	function on(eventName, func){
		switch(eventName.toUpperCase()){
		case "UPLOADCOMPLETE" :
			$DZID.off("uploadComplete");
			$DZID.on("uploadComplete", function(e, data){
				if(data == 0)
					data = -1;
				func(e, data);
			});
			break;
		}
		return this;
	}

	/**
	 * 드래그앤드랍 파일의 메인 이벤트 핸들러
	 * @param areaId 드랍존이 생성될 영역의 ID
	 * @param uploadParam {
	 * 			btnId : 업로드를 실행할 트리거 버튼 ID  (필수)
	 * 			url : 업로드 Url  ( 기본값 = dragdrop공통 업로드 url )6
	 * 			formData : 업로드할 파일 폼데이터 ( 기본값 = 드래그앤드랍으로 드랍존에 올린 파일들의 폼데이터)
	 * 			success : 업로드 성공시 실행할 콜백함수 ( 리턴 값 : 업로드 처리한 fileIdx )
	 *          event : 업로드 트리거 버튼의 event ( 기본값 : click )
	 *          height : 드랍존 최대 높이 설정
	 *          readOnly : 드랍존 readonly 여부 ( true, false )
	 *          maxFiles : 첨부파일 최대 허용 갯수(숫자)
	 *          inFileType : 해당 확장자만 파일 업로드 할수 있다. ["xls","pdf"]
	 *			}
	 */
	function EventHandler(areaId, uploadParam){
		uploadParam = uploadParam == undefined ? new Object() : uploadParam;

		var $target = null; //삭제 시 해당 파일 Object를 담을 변수
		var initTarget = function(){ $target = null; };

		var dzId = createDropzone(areaId); //드랍존 생성
		var maxFileCount = 5;
		var inFileType;

		if (uploadParam.maxFiles != undefined){
			maxFileCount = uploadParam.maxFiles;
		}

		if (uploadParam.inFileType != undefined){
			inFileType = uploadParam.inFileType;
		}

		Dropzone.autoDiscover = false;
		var self = new Dropzone( dzId , {
						uploadMultiple : true
						, maxFiles : maxFileCount
						, thumbnailWidth: 120
						, thumbnailHeight:120
						, lang : uploadParam.lang
						, previewTemplate: '<div class="uploaded-image"><span class="dzClass"><span data-dz-name></span> <strong class="dz-size" data-dz-size></strong><span class="dz-error-message" data-dz-errormessage></span><span class="dz-progress"><span class="dz-upload" data-dz-uploadprogress></span></span></span></div>'
						}
					);

				  if(uploadParam.readOnly)
				 	 readOnly(true);
				  if(uploadParam.height != undefined){
					  $(".dropzone").css("max-height", uploadParam.height+"px");
				      $(".dropzone").css("min-height", uploadParam.height+"px");
				  }

				  if(uploadParam.lang != undefined){
					  $(".dz-message").text(uploadParam.lang);
				  }

 				  var count = 0;
			      var initCount = function(){
			    	  count = 0;
			      };

			      //읽기전용 모드이면 다운로드만 가능하게
			      $("#"+$(self.element).attr("id")).on("mouseenter mouseleave", function(){
			    	  if(readOnlyFlag){
			    		  self.disable();
			    		  $(this).sortable( "disable" );
			    	  }else{
			    		  self.enable();
			    		  $(this).sortable( "enable" );
			    	  }
			      });
			      //정렬 이벤트
			      $("#"+$(self.element).attr("id")).sortable({
			    	  items : "> .dz-preview",
			    	  helper: "clone",
			    	  appendTo: "body",
			    	  start : function( event, ui ) {
		    			  initCount();
		    			  $target = $(event.originalEvent.target).parents(".dz-preview"); //드래그 대상 객체 저장

		    			  //sortable과 overflow와의 충돌로 임시 css 적용
		    			  $(ui.helper).find(".dz-preview,.dz-details,.dz-progress,.dz-error-message,.dz-success-mark,.dz-error-mark").hide();
		    			  $(ui.helper).find(".dz-image > img").width(120).height(120).css({"border-radius" : "20px",
		    				  "background": "#999", "background": "linear-gradient(to bottom, #eee, #ddd)" });
			    	  },
			    	  over : function( event, ui ) {
			    		  count--;
			    	  },
			    	  out : function( event, ui ) {
			    		  count++;
			    	  },
			    	  beforeStop : function( event, ui) { //드래그가 끝날 때 카운트가 0이면 삭제 실행
			    		  //파일 삭제 이벤트
			    		  if( count === 0){
			    			  if(!confirm("해당 파일을 삭제하시겠습니까?"))
			    				  return;
			    			  fileCount = fileCount-1;
			    			  var check = deleteAcceptedFiles(self, $target); //삭제할 파일이 서버에 저장되지 않은 파일이라면 삭제 후 true 리턴
			    			  if(!check) $target.trigger("deleteFileEvent"); //서버에서 불러온 파일 삭제 이벤트 트리거
		    				  initTarget(); //드래그 대상 객체 초기화
			    		  }
			    	  },
			    	  deactivate : function( event, ui ) {
			    		  orderSaveEventHandler(self); //정렬이 끝날 때 순서 저장
			    	  }
			      });

			      //드랍존에 파일들이 올라올때 실행
			      self.on("accept", function(file,done){
			    	  if(file != null){
			    		  fileCount++;
			    	  }
			      });

			      self.on("removefiles", function(file,done){
			      })

			      //드랍존에 파일이 추가될 때 이벤트
			      self.on("addedfile", function(file) {
			    	  addedFileEventHandler(self, file, maxFileCount, inFileType);
			      });

			      //파일을 드랍존에 올릴 때 폼데이터 세팅
			      self.on("successmultiple", function(file){
			    	  if(lockFlag.lock){
			    		  if(lockFlag.msg != undefined && lockFlag.msg != "")
                                warn(lockFlag.msg);
			    		  if(lockFlag.clear)
			    			    clear();
				    	  return false;
			    	  }
			    	  successMultipleEventHandler(self, file);
			      });
			      //드랍존 초기화 이벤트
			      $(self.element).on("emptyDropzone", function(e){
			    	  self.removeAllFiles();
			    	  $(self.element).find(".dz-preview").remove();
			    	  $(self.element).find(".uploaded-image").remove();
			    	  $DZID.removeClass("dz-started");
			      });

			      $(self.element).on("getFiles", function(e, getFilesAfterFunc){
			    	  getFilesEventHandler(self, { "atchmnflSeqno" : getFileIdx() }, getFilesAfterFunc );
			     });

			     uploadActionEventHandler( self, uploadParam );

		return this;
	}

	/**
	 * 드랍존 생성
	 * @return 생성된 드랍존의 id 리턴
	 */
	function createDropzone(areaId){
		var dzId = null;
		if(typeof areaId == "string"){
			areaId = areaId[0] != "#" && areaId[0] != "." ? "#"+areaId : areaId;
			dzId = areaId[0] == "#" ? "dz-"+areaId.slice(1).replace(/\s/g, "").replace(/#|\./, "-") : "dz-"+areaId.replace(/\s/g, "").replace(/#|\./, "-");
		}else{
			throw "Dropzone Id는 문자열이어야 합니다.";
		}
		var html = "<form action=\"/sys/dropZone.lims\" class=\"dropzone\" id="+dzId+">"
				   + "<input type=\"hidden\" id=\"fileIdx\" name=\"fileIdx\"/></form>";

		if( $(areaId).length == 0 ){
			throw areaId + " 드랍존을 생성할 영역을 찾을 수 없습니다.";
		}
		$(areaId).append(html);
		$DZID = $("#"+dzId);

		return "#"+dzId;
	}

	/**
	 * 드랍존 초기화
	 */
	function clear(){
		$DZID.find("#fileIdx").val("");
		$DZID.trigger("emptyDropzone");
		initFiles();
		initOrdArr();
		fileCount = 0;

		return this;
	}

	/**
	 * 해당 파일 번호로 저장된 파일들을 불러와서 드랍존에 세팅
	 */
	function getFiles(fileIdx, getFilesAfterFunc,getDeleteButtonYn){
		if(fileGetting == false){
			fileGetting = true;
			clear();
			setFileIdx(fileIdx);
			if(getDeleteButtonYn != null && getDeleteButtonYn != '' && typeof getDeleteButtonYn != "undefined" ){
			deleteButtonYn = getDeleteButtonYn
			}
			lockFlag.lock = false;
			$DZID.trigger("getFiles", getFilesAfterFunc);
			defaultMessageHandler($DZID);
		}

		return this;
	}

	/**
	 * 드랍존에 세팅되는 파일들의 uuid 설정
	 */
	function setUuid(self, fileNm, uuid, index){
		$($(self.element).find(".dzClass")[index]).append("<div class=\"dz-uuid\" style=\"display:none;\"><span>"+uuid+"</span></div>");
		setOrdArr(fileNm, uuid, index); //현재 정렬 순서대로 파일 정보 저장
	}

	function defaultMessageHandler(self){
		 if($(self.element).find(".dz-preview").length != 0) //드랍존 안에 파일이 남아있다면
			  $DZID.addClass("dz-started");  //기본 문구 안보이게
		 /*
		  * 리스트형식 드랍존인결우 기본문구가 나타나지않도록
		  * */
		 if($(self.element).find(".uploaded-image").length != 0) //드랍존 안에 파일이 남아있다면
			 $DZID.addClass("dz-started");  //기본 문구 안보이게
	}

	/**
	 * 삭제할 파일이 서버에 저장되지 않은 신규 파일이라면
	 */
	function deleteAcceptedFiles(self, $target){
		  var acceptedFiles = self.getAcceptedFiles(); //서버에 저장하지 않은 새로 올린 파일 목록

		  for(var i = 0 ; i<acceptedFiles.length; i++)  {
			  self.removeFile(acceptedFiles[i]);
			  deleteFiles(acceptedFiles[i].upload.uuid);
			  defaultMessageHandler(self); //드랍존 안에 파일 정보가 존재할 때는 기본 문구 안보이게
			  return true;

			  /*if($target.find('.dz-uuid').text() == acceptedFiles[i].upload.uuid){
				  self.removeFile(acceptedFiles[i]);
				  deleteFiles(acceptedFiles[i].upload.uuid);
				  defaultMessageHandler(self); //드랍존 안에 파일 정보가 존재할 때는 기본 문구 안보이게
				  return true;
			  }*/
		  }
	}

	/*
	 * 버튼 삭제 파일이 서버에 저장되지 않은 신규파일 삭제
	 * */
	function deleteButtonAcceptedFiles(file,self){
		//선택된 파일이 저장이 되어있는지 확인
		if(file.atchmnflSeqno == null || file.atchmnflSeqno == '' ){
			self.removeFile(file);
			deleteFiles(file.upload.uuid);
			defaultMessageHandler(self); //드랍존 안에 파일 정보가 존재할 때는 기본 문구 안보이게
			return true;
		}
	}

	/**
	 * 드랍존에 파일 추가 시
	 */
	function addedFileEventHandler(self, file, maxFileCount, inFileType){

		var remove_button = Dropzone.createElement(dz_delete_button);

		var _this = this;


		if (inFileType != undefined){
			var _fileLen = file.name.length;
			var _lastDot = file.name.lastIndexOf('.') + 1;
			var _fileExt = file.name.substring(_lastDot, _fileLen).toLowerCase();
			var typeCnt = 0;
			var uploadParamType = inFileType;
			var fileType = "";

			for(var i=0; i<uploadParamType.length; i++){
				if(uploadParamType[i].toLowerCase() != _fileExt){
					typeCnt ++;
	  		  	}
			}

			if(typeCnt == uploadParamType.length){
				var str = "";

				for(var i=0; i<uploadParamType.length; i++){
					if(i == 0){
						str += uploadParamType[i];
					}
					else{
						str += ", " + uploadParamType[i];
					}

				}

				warn(str + " 파일만 업로드 할 수 있습니다.");
				self.removeFile(file);
				defaultMessageHandler(self);
	  			return false;
	  	 	}

		}

		remove_button.addEventListener('click', function (e) {
			e.preventDefault(); // click이벤트 외의 이벤트 막기위해
			e.stopPropagation(); // 부모태그로의 이벤트 전파를 중지
			// 파일 업로드시 장애가 발생한 경우
			if (file['status'] != 'error') {
				// Send Client Event Delete
				}
			// 첨부파일 필수값일 경우 th에 necessary class 추가
			var required = $(this).parents()[4].children[0].className;  // th 필수값 표시 여부
			var fileValid = $(this).parents()[2].childNodes[0].length;  // 파일 갯수
			if(required == "necessary" && fileValid == 2) { // 필수값이고 파일이 1개인 경우
				warn("최소 1개의 파일은 유지해야합니다. 새로운 파일을 먼저 등록하고 삭제해주세요.");
				return;
			}
			if(!confirm("해당 파일을 삭제하시겠습니까?"))
				  return;
			  fileCount = fileCount-1;
			  var check = deleteButtonAcceptedFiles(file,self); //삭제할 파일이 서버에 저장되지 않은 파일이라면 삭제 후 true 리턴
			  if(!check) {
			 deleteAction("/sys/dragDropDeleteAction.lims", param, function(data){ //파일 삭제
	  	  		  if(data != 0){
	  	  			  self.removeFile(file); //파일 삭제
	  	  			  console.log(file);
	  	  			  console.log($(file.previewElement).find(".dz-uuid").text());
	  	  			  deleteOrdArr($(file.previewElement).find(".dz-uuid").text()); //현재 정렬 순서를 저장한 배열에서 삭제한 파일 정보 제거
	  	  			  defaultMessageHandler(self);
					
					  if(required == "necessary") {
						uploadActionEventHandler( self, uploadParam );
					  }
	  	  		  }
	  	  	  });
			  }
			});
		if(deleteButtonYn == 'Y'){
			file.previewElement.insertBefore(remove_button,$(file.previewElement).children()[0])
		}

		if ($(self.element).find(".dzClass").length > maxFileCount){
			warn("최대 첨부파일 갯수는 ( " + maxFileCount + " )개 입니다.");
			self.removeFile(file);
			defaultMessageHandler(self);
			return false;
		}


		/*removeButton.addEventListener("click", function(e) {
			if(!confirm("해당 파일을 삭제하시겠습니까?"))
				  return;
			 deleteAction("/sys/dragDropDeleteAction.lims", param, function(data){ //파일 삭제
	  	  		  if(data != 0){
	  	  			  self.removeFile(file); //파일 삭제
	  	  			  deleteOrdArr($(file.previewElement).find(".dz-uuid").text()); //현재 정렬 순서를 저장한 배열에서 삭제한 파일 정보 제거
	  	  			  defaultMessageHandler(self);
	  	  		  }
	  	  	  });

	        });*/


		var uuid = $(file.previewElement).find(".dz-uuid").text();
		var param = { "atchmnflSeqno" : file.atchmnflSeqno, "fileSeqno" : file.fileSeqno, "fileMg" : file.size };

  	  //드랍존에 끌어온 파일 객체의 uuid 세팅
  	  if(file.atchmnflSeqno == undefined || file.fileSeqno == undefined ){ //새로 업로드할 파일이라면
  		  var cnt = $(self.element).find(".dzClass").length;
  		  setUuid(self, file.orginlFileNm, file.uuid, Number(cnt)-1);
  	  }

  	  //파일이 추가될 때 해당 파일의 삭제 이벤트 정의
  	  $(file.previewElement).on("deleteFileEvent", function(e){
  	  	  deleteAction("/sys/dragDropDeleteAction.lims", param, function(data){ //파일 삭제
  	  		  if(data != 0){
  	  			  self.removeFile(file); //파일 삭제
  	  			  deleteOrdArr($(file.previewElement).find(".dz-uuid").text()); //현재 정렬 순서를 저장한 배열에서 삭제한 파일 정보 제거
  	  			  defaultMessageHandler(self);
  	  		  }
  	  	  });
  	  });

  	  $(file.previewElement).on("click", function(e){

        if(file.fileSeqno == undefined || file.atchmnflSeqno == undefined){
            warn("저장된 파일만 다운로드가 가능합니다.");
            return false;
        }

  		  downloadAction("/sys/dragDropDownloadAction.lims", param);
  	  });
	}

	/**
	 * 파일을 드랍존에 올렸을 때 이벤트
	 */
	function successMultipleEventHandler(self, file){
    	for(var i=0; i<file.length; i++)
    		setFiles(file[i]);
	}

	/**
	 * 해당 파일 번호가 가진 파일들을 호출하는 커스텀 이벤트
	 * @param { "fileIdx" : fileIdx }
	 */
	function getFilesEventHandler(self, param, getFilesAfterFunc){
	 	  //파일 정보를 가져온 뒤 드랍존에 세팅
		customAjax({"url":"/sys/dragDropGetFileList.lims","data":param,"successFunc":function(data){
//		ajaxJsonParam("/sys/dragDropGetFileList.lims", param, function(data){
  			for(var i = 0 ; i<data.length; i++)  {
	  			var obj = new Object();
	  			obj.atchmnflSeqno = data[i].atchmnflSeqno;
	  			obj.fileSeqno = data[i].fileSeqno;
	  			obj.name = data[i].orginlFileNm;
	  			obj.size = data[i].fileMg;


	  			self.emit("addedfile", obj); //파일 정보 세팅
	  			self.emit("thumbnail", obj, "/sys/dragDropGetImage.lims?filePath="+encodeURI(data[i].streFileNm)); //미리보기 이미지 세팅
	  			self.emit("accept",obj);

	  			setUuid(self, data[i].orginlFileNm, data[i].uuid, Number(i));
	  		}
	  		fileGetting = false;
	  		deleteButtonYn = 'Y';
	  		$(self.element).find(".dz-progress").css("display", "none"); //프로그레스바 숨기기

	  		if(typeof getFilesAfterFunc == "function"){
	  			getFilesAfterFunc();
	  		}
		}
	  	});
	}

	/**
	 * 파일이 재정렬 될 때 순서 저장
	 */
	function orderSaveEventHandler(self){
		var orgArr = getOrdArr();
		var item = $(self.element).find(".dzClass");
		var uuid = null;
		for(var i=0; i<item.length; i++){
			uuid = $(item[i]).find(".dz-uuid").text();
			for(var i = 0 ; i<ordArr.length; i++)  {
				if(uuid == ordArr[i].uuid)
					ordArr[i].ord = i;
			}
		}
	}

	/**
	 * 업로드 이벤트 핸들러
	 * @return 업로드 된 파일 번호
	 */
	function uploadActionEventHandler( self, uploadParam ){

        var btnId = uploadParam.btnId;
        btnId = typeof btnId != "string" ? undefined : btnId[0] == "#" ? btnId : "#"+btnId;
        var event = uploadParam.event;
        event = event == undefined ? "click" : event;

        if( !!btnId ){
            $(btnId).wrap('<span id="btnUpload_' + btnId.replace("#","") +'"></span>');
            $("#btnUpload_" + btnId.replace("#","")).on("click", function(e){ //이벤트 버블링, 트리거 버튼의 click이벤트에서 upload(false)했을 때는 업로드 중지
                e.stopPropagation();
                $(btnId).trigger("uploadClick", true);
            });
    
            $(btnId).on("uploadClick", function(e, flag){
    
                if(flag != undefined) upload(flag);
                if(uploadFlag != true) return;
                upload(false);
    
                if(uploadParam == undefined)
                    uploadParam = new Object();
    
                //업로드 성공 콜백 함수 세팅
                var successFunc = function(data, xhr){
                    if(uploadParam.success != undefined)
                    uploadParam.success(data, xhr); //사용자 정의 업로드 success 콜백 함수
    
    
                    var uploadCompleteEventTrigger = function(){
                        $DZID.trigger("uploadComplete", data); //uploadComplete 이벤트 트리거
                    }
                    getFiles(data, uploadCompleteEventTrigger); //getFiles 이후 트리거
                    //저장 버튼 클릭 시 파일의 정렬된 순서 저장
                };
    
                //업로드 url 세팅
                if(uploadParam.url == undefined)
                    uploadParam.url = "/sys/dragDropUploadAction.lims";
                //업로드 폼데이터 세팅
                if(uploadParam.formData != undefined){
                    formData = uploadParam.formData;
                }else{
                    var files = getNewFiles();
                    var uuidArr = new Array();
                    for(var i = 0 ; i<files.length;i ++)
                        uuidArr.push(files[i].upload.uuid);
    
                    setFormData("files", files); //파일 정보 세팅
                    setFormData("uuids", uuidArr); //각 파일의 uuid 세팅
                }
    
                var fileIdx = getFileIdx();
    
    
                var amountFiles = {
                        "totFileMg" : 0,
                        "totFileCnt" : 0,
                        "atchmnflSeqno" : fileIdx,
                        "revision" : revision
                }
    
                for(var i = 0; i < files.length; i++){
                    amountFiles.totFileMg += files[i].size;
                    amountFiles.totFileCnt++;
                }
    
                //파일 총 합계 등록 및 수정
                customAjax({"url":"/sys/dragDropAmountUpload.lims","data":amountFiles,"successFunc":function(data){
    //			 ajaxJsonParam("/sys/dragDropAmountUpload.lims",amountFiles,function(data){
                //업로드할 파일 인덱스 세팅
                    setFormData("fileIdx", data);
                    uploadAction(uploadParam.url, formData, successFunc);
                }
                });
            });
        }
	}
	/**
	 * 업로드
	 */
	function uploadAction(url, formData, successFunc){
		var xhr = new XMLHttpRequest();
	    xhr.onload = function(data){
	    	if(xhr.status === 200){
	    		if(successFunc != undefined)
	    			successFunc(JSON.parse(data.target.response), xhr);//업로드 성공시 콜백 함수 실행
	    	}
	    };
	    xhr.open('POST', url);
	    xhr.setRequestHeader('encType', 'multipart/form-data'); // 컨텐츠타입을 multipart로
	    xhr.send(formData); // 데이터를 stringify해서 보냄
	    initFormData(); //업로드 후 폼 데이터 초기화
	}

	/**
	 * 파일 다운로드
	 */
	function downloadAction(url, param){
		if(url != undefined)
			location.href = url + "?atchmnflSeqno="+param.atchmnflSeqno+"&fileSeqno="+param.fileSeqno;
	}

	/**
	 * 파일 삭제
	 */
	function deleteAction(url, param, successFunc){
		customAjax({"url":url,"data":param,"successFunc":function(data){
//		ajaxJsonParam(url,param,function(data){
			if(data == 0){ // 저장된 데이터가 0일 경우
				err('첨부파일 삭제에 실패하였습니다');
			} else if(successFunc != undefined){
				successFunc(data);
			}
		}
		});
	}

	/**
	 * 파일 정렬 순서 저장
	 */
//	function updOrdAction(successFunc){
//		var ordArr = getOrdArr();
//		ajaxJsonParam("/sys/dragDropUpdOrd.lims",ordArr, function(data){
//			if(successFunc != undefined) successFunc(data);
//		});
//	}

	return {
		 EventHandler : EventHandler
		,getFiles : getFiles //인자로 넘긴 파일 번호에 해당하는 파일들을 드랍존에 세팅
		,setFileIdx : setFileIdx  //파일 번호 세팅
		,getFileIdx : getFileIdx //파일 번호 가져오기
		,on : on //이벤트 리스너
		,upload : upload //업로드 실행 여부
		,clear : clear //드랍존 초기화
		,lock : lock //드랍존에 파일 업로드 불가
		,getNewFiles : getNewFiles //새로 추가한 파일들의 목록을 리턴
		,bind : bind //한 화면에서 여러 드랍존을 사용하고자 할 때 이 함수를 호출하여 변수에 할당
		,readOnly : readOnly //다운로드(더블 클릭)만 가능
		,setRevision : setRevision
		,getOrdArr : getOrdArr
			};
}
