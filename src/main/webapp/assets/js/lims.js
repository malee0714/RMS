/**
 * Object.assign pollyfill
 */
if (!Object.assign) {
  Object.defineProperty(Object, 'assign', {
    enumerable: false,
    configurable: true,
    writable: true,
    value: function(target) {
      'use strict';
      if (target === undefined || target === null) {
        throw new TypeError('Cannot convert first argument to object');
      }

      var to = Object(target);
      for (var i = 1; i < arguments.length; i++) {
        var nextSource = arguments[i];
        if (nextSource === undefined || nextSource === null) {
          continue;
        }
        nextSource = Object(nextSource);

        var keysArray = Object.keys(Object(nextSource));
        for (var nextIndex = 0, len = keysArray.length; nextIndex < len; nextIndex++) {
          var nextKey = keysArray[nextIndex];
          var desc = Object.getOwnPropertyDescriptor(nextSource, nextKey);
          if (desc !== undefined && desc.enumerable) {
            to[nextKey] = nextSource[nextKey];
          }
        }
      }
      return to;
    }
  });
}

if (!String.prototype.includes) {
  String.prototype.includes = function(search, start) {
    'use strict';
    if (typeof start !== 'number') {
      start = 0;
    }

    if (start + search.length > this.length) {
      return false;
    } else {
      return this.indexOf(search, start) !== -1;
    }
  };
}

//From https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/keys
if (!Object.keys) {
  Object.keys = (function() {
    'use strict';
    var hasOwnProperty = Object.prototype.hasOwnProperty,
        hasDontEnumBug = !({ toString: null }).propertyIsEnumerable('toString'),
        dontEnums = [
          'toString',
          'toLocaleString',
          'valueOf',
          'hasOwnProperty',
          'isPrototypeOf',
          'propertyIsEnumerable',
          'constructor'
        ],
        dontEnumsLength = dontEnums.length;

    return function(obj) {
      if (typeof obj !== 'function' && (typeof obj !== 'object' || obj === null)) {
        throw new TypeError('Object.keys called on non-object');
      }

      var result = [], prop, i;

      for (prop in obj) {
        if (hasOwnProperty.call(obj, prop)) {
          result.push(prop);
        }
      }

      if (hasDontEnumBug) {
        for (i = 0; i < dontEnumsLength; i++) {
          if (hasOwnProperty.call(obj, dontEnums[i])) {
            result.push(dontEnums[i]);
          }
        }
      }
      return result;
    };
  }());
}

//IE11 has an incomplete implementation of Set which doesn't allow you to iterate the keys
//so this code assumes you want a full implementation and will redefine Set if the half
//implementation is present
if (typeof Set === "undefined" || typeof Set.prototype.keys !== "function") {
 var Set = (function() {
     "use strict";

     var iterables = {
         "[object Array]": true,
         "[object Arguments]": true,
         "[object HTMLCollection]": true,
         "[object NodeList]": true
     };

     // shortcuts
     var hasOwn = Object.prototype.hasOwnProperty;
     var toString = Object.prototype.toString;

     function hasOwnProp(obj, prop) {
         return hasOwn.call(obj, prop);
     }

     function isIterable(item) {
         // for purposes of this implementation, an iterable is anything we can iterate with
         // a classic for loop:
         //     for (var i = 0; i < item.length; i++)
         // Currently accepts: array, arguments object, HTMLCollection, NodeList
         // and anything that has a .length with a numeric value and, if .length > 0, the first item has a nodeType property
         var name;
         if (typeof item === "object") {
             name = toString.call(item);
             return ((iterables[name] === true) ||
                 (typeof item.length === "number" &&
                     item.length >= 0 &&
                     (item.length === 0 || (typeof item[0] === "object" && item[0].nodeType > 0))
                 )
             );
         }
         return false;
     }

     // decide if we can use Object.defineProperty
     // include a test for Object.defineProperties (which IE8 does not have) to eliminate
     // using the broken Object.defineProperty in IE8
     var canDefineProperty = Object.defineProperty && Object.defineProperties;

     function setProperty(obj, propName, value, enumerable, writable) {
         if (canDefineProperty) {
             Object.defineProperty(obj, propName, {
                 enumerable: enumerable,
                 configurable: false,
                 writable: writable,
                 value: value
             });
         } else {
             obj[propName] = value;
         }
     }

     // this private function is used like a private method for setting
     // the .size property.  It cannot be called from outside this closure.
     var settable = false;
     function setSize(obj, val) {
         settable = true;
         obj.size = val;
         settable = false;
     }

     // this is the constructor function which will be returned
     // from this closure
     function SetConstructor(arg) {
         // private member variable, not used if IE8
         var size = 0;

         // set properties in cross-browser way
         setProperty(this, "baseType", "Set", false, false);   // not enumerable, not writeable
         setProperty(this, "_data", {}, false, true);          // not enumerable, writeable
         if (canDefineProperty) {
             Object.defineProperty(this, "size", {
                 enumerable: true,
                 configurable: false,
                 get: function() { return size;},
                 set: function(val) {
                     if (!settable) {throw new Error("Can't set size property on Set object.")}
                     size = val;
                 }
             });
         } else {
             // .size is just regular property in IE8
             this.size = 0;
         }
         // now add initial data
         // per spec make sure it isn't undefined or null
         if (arg !== undefined && arg !== null) {
             if (isIterable(arg)) {
                 for (var i = 0; i < arg.length; i++) {
                     this.add(arg[i]);
                 }
             // also check our own custom property in case
             // there is cross window code that won't pass instanceof
             } else if (arg instanceof Set || arg.baseType === "Set") {
                 arg.forEach(function(item) {
                     this.add(item);
                 }, this);
             }
         }
     }

     // state variables and shared constants
     var objectCntr = 0;
     var objectCntrBase = "obj_";
     var objectCntrProp = "__objectPolyFillID";

     // types where we just use the first 3 letters of the type
     // plus underscore + toString() to make the key
     // The first 3 letters of the type makes a namespace for each
     // type so we can have things like 0 and "0" as separate keys
     // "num_0" and "str_0".
     var autoTypes = {
         "string": true,
         "boolean": true,
         "number": true,
         "undefined": true
     };

     function getKey(val, putKeyOnObject) {
         // manufacture a namespaced key
         var type = typeof val, id;
         if (autoTypes[type]) {
             return type.substr(0, 3) + "_" + val;
         } else if (val === null) {
             return "nul_null";
         } else if (type === "object" || type === "function") {
             // coin a unique id for each object and store it on the object
             if (val[objectCntrProp]) {
                 return val[objectCntrProp];
             } else if (!putKeyOnObject) {
                 // it only returns null if there is no key already on the object
                 // and it wasn't requested to create a new key on the object
                 return null;
             } else {
                 // coin a unique id for the object
                 id = objectCntrBase + objectCntr++;
                 // include a test for Object.defineProperties to rule out IE8
                 // which can't use Object.defineProperty on normal JS objects
                 if (toString.call(val) === "[object Object]" && canDefineProperty) {
                     Object.defineProperty(val, objectCntrProp, {
                         enumerable: false,
                         configurable: false,
                         writable: false,
                         value: id
                     });
                 } else {
                     // no Object.defineProperty() or not plain object, so just assign property directly
                     val[objectCntrProp] = id;
                 }
                 return id;
             }
         } else {
             throw new Error("Unsupported type for Set.add()");
         }
     }

     function SetIterator(keys, data, format) {
         var index = 0, len = keys.length;
         this.next = function() {
             var val, result = {}, key;
             while (true) {
                 if (index < len) {
                     result.done = false;
                     key = keys[index++];
                     val = data[key];
                     // check to see if key might have been removed
                     // undefined is a valid value in the set so we have to check more than that
                     // if it is no longer in the set, get the next key
                     if (val === undefined && !hasOwnProp(data, key)) {
                         continue;
                     }
                     if (format === "keys") {
                         result.value = val;
                     } else if (format === "entries") {
                         result.value = [val, val];
                     }
                 } else {
                     // clear references to outside data
                     keys = null;
                     data = null;
                     result.done = true;
                 }
                 return result;
             }
         };
     }

     function getKeys(data) {
         var keys = [];
         for (var prop in data) {
             if (hasOwnProp(data, prop)) {
                 keys.push(prop);
             }
         }
         return keys;
     }

     SetConstructor.prototype = {
         add: function(val) {
             var key = getKey(val, true);
             if (!hasOwnProp(this._data, key)) {
                 this._data[key] = val;
                 setSize(this, this.size + 1);
             }
             return this;
         },
         clear: function() {
             this._data = {};
             setSize(this, 0);
         },
         // delete has to be in quotes for IE8 - go figure
         "delete": function(val) {
             var key = getKey(val, false);
             if (key !== null && hasOwnProp(this._data, key)) {
                 delete this._data[key];
                 setSize(this, this.size - 1);
                 return true;
             }
             return false;
         },
         // .remove() is non-standard, but here for anyone who wants to use it
         // so that you can use this polyfill all the way down to IE7 and IE8
         // since IE8 can't use a method named .delete()
         remove: function(val) {
             return this["delete"](val);
         },
         forEach: function(fn /*, context */) {
             // by spec, we have to type check the fn argument
             if (typeof fn !== "function") return;

             // context argument is optional, but .forEach.length is supposed to be 1 by spec
             // so we declare it this way
             var context = arguments[1];

             // forEach specifies that the iteration set is
             // determined before the first callback so we get all the
             // keys first
             var iter = this.keys(), next, item;
             while ((next = iter.next()) && !next.done) {
                 item = next.value;
                 fn.call(context, item, item, this);
             }
         },
         has: function(val) {
             var key = getKey(val, false);
             if (key === null) return false;
             return hasOwn.call(this._data, key);
         },
         values: function() {
             return this.keys();
         },
         keys: function() {
             return new SetIterator(getKeys(this._data), this._data, "keys");
         },
         entries: function() {
             return new SetIterator(getKeys(this._data), this._data, "entries");
         }
     };

     SetConstructor.prototype.constructor = SetConstructor;

     return SetConstructor;
 })();
}

jQuery.fn.serializeObject = function() {
    var obj = null;
    try {
        if (this[0].tagName && this[0].tagName.toUpperCase() == "FORM") {
            var arr = this.serializeArray();
            if (arr) {
                obj = {};
                jQuery.each(arr, function() {
                	if(obj[this.name] != undefined) {
               			obj[this.name] = obj[this.name] + "," + this.value;
                	} else {
                        obj[this.name] = this.value;
                	}
                });
            }//if ( arr ) {
        }
    } catch (e) {
        warn(e.message);
    } finally {
    }

    return obj;
};

var getEl = function(id){
	return document.getElementById(id);
};

Element.prototype.event = function(e, func){
	return this.addEventListener(e,func);
}


//replaceAll prototype 선언
String.prototype.replaceAll = function(org, dest) {
    return this.split(org).join(dest);
}

//각 페이지에 권한 체크
function getAuth(successfunction, errorfunction, completefunction){
	return $.ajax({
        url : '/com/getAuth.lims',
        method: "post",
        type: "json",
        async: true,
        contentType: "application/json; charset=utf-8",
        data : null,
        beforeSend : function(xmlHttpRequest){
            xmlHttpRequest.setRequestHeader("AJAX", "true"); // ajax 호출을  header에 기록
        },
        success : function(data,status,request){
        	if(!data.streAuthorAt || data.streAuthorAt == "N"){//저장 권한이 없으면 저장 (.save) 버튼 숨기기
        		var save = document.getElementsByClassName("save");

        		for(var i=0; i<save.length; i++){
        			save[i].disabled = true;
        			save[i].style.opacity = "0";
        			save[i].style.width="0px";
        			save[i].style.height="0px";
        			save[i].style.padding="0px";
        			save[i].style.cursor="default";
        		}
        	}

        	if(!data.inqireAuthorAt || data.inqireAuthorAt == "N"){//조회 권한이 없으면 저장 (.save) 버튼 숨기기
        		var search = document.getElementsByClassName("search");

        		for(var i=0; i<search.length; i++){
        			search[i].disabled = true;
        			search[i].style.opacity = "0";
        			search[i].style.width="0px";
        			search[i].style.height="0px";
        			search[i].style.padding="0px";
        			search[i].style.cursor="default";
        		}
        	}

        	if(!data.deleteAuthorAt || data.deleteAuthorAt == "N"){//저장 권한이 없으면 저장 (.save) 버튼 숨기기
        		var del = document.getElementsByClassName("delete");

        		for(var i=0; i<del.length; i++){
        			del[i].disabled = true;
        			del[i].style.opacity = "0";
        			del[i].style.width="0px";
        			del[i].style.height="0px";
        			del[i].style.padding="0px";
        			del[i].style.cursor="default";
        		}
        	}

        	if(!data.outptAuthorAt || data.outptAuthorAt == "N"){//조회 권한이 없으면 저장 (.save) 버튼 숨기기
        		printAuth = "N";
        	}else{
        		printAuth = "Y";
        	}

            if( typeof successfunction == "function" ){
                successfunction();
            }
        },
        error : function(request,status,error) {
        	if(request.status == 401) {
        		err("다시 로그인하여야 합니다.");
        		document.location.href="/logout.lims";
        		return false;
        	} else {
        		if(request.responseText != undefined){
        			var errorlog = JSON.parse(request.responseText);
        			err("요청이 중단되었습니다. (" + errorlog.error.excpLogSeqno + ")\n");
        		}
        	}
        	if(errorfunction != undefined && errorfunction != null)
        		errorfunction(request,status,error);
        },
        complete : function(request,status) {
        	if(completefunction != undefined && completefunction != null)
        		completefunction(request,status);
        }
	});
}

/**
 * @param {Object} param {
 *     bplcCode     : 현재 user session의 사업장 코드
 *     authorSeCode : 현재 user session의 권한 코드
 *     menuUrl      : 현재 메뉴 url
 * }
 * 
 * @author shs
 * @see all.js
 */
function BplcCodeSupport(param) {
    this.userBplcCode = param.bplcCode;     // 사업장 code (공통코드)
    this.authorSeCode = param.authorSeCode; // 권한 코드
    this.menuUrl = param.menuUrl;           // menu url
    this.userMenuUrl = '/wrk/UserM.lims';   // 사용자 메뉴
    this.prductMenuUrl = '/wrk/PrductM.lims'; // 자재관리 메뉴
    this.specialMenus = ['/wrk/OrgM.lims']; // 예외적인 특별한 메뉴
    this.BPLC_KEY = 'bplcCodeSch';          // 사업장 Element key
    this.menuUpperpath = param.menuUrl.substr(0, 4); // 페이지 상위 경로 (대메뉴 "조회"는 사업장 권한별 disabled처리 안함)
    
    // 사용자관리 메뉴입니까 ?
    this.isUserMenu = function () {
        return this.menuUrl === this.userMenuUrl;
    };

    // 자재관리 메뉴입니까 ?
    this.isPrductMenuUrl = function () {
        return this.menuUrl === this.prductMenuUrl;
    };

    // 사업장 Element get
    this.getBplcElements = function () {
        var bplcElements = document.querySelectorAll('select[name='+ this.BPLC_KEY +']');
        if (bplcElements.length > 0) {
            return {'keyType' : 'name', element : bplcElements};
        } else if (bplcElements.length === 0) {
            return {'keyType': 'id', element: document.querySelector('#' + this.BPLC_KEY)};
        }
    };

    // 시스템 관리자 입니까 ?
    this.isSystemAdmin = function () {
        return this.authorSeCode === 'SY09000001';
    };

    // 사업장 관리자 입니까 ?
    this.isBplcAdmin = function () {
        return this.authorSeCode === "SY09000002";
    };

    // 일반 or 고객사 사용자 입니까 ?
    this.isGeneralOrCustomer = function () {
        return this.authorSeCode === "SY09000003" || this.authorSeCode === "SY09000004" 
    };

    // 특별 메뉴를 제외한 모든 메뉴는 rdms ip가 true
    this.isRdmsIp = function () {
        var findMenu = this.specialMenus.filter(function (menu) {
            return menu === this.menuUrl;
        }, this);
        return findMenu.length === 0;
    };

    // 권한코드가 시스템관리자이면 모든 사업장 조회. 아니면, rdms ip가 true인 사업장만
    this.createQueryParam = function () {
        var queryParam;

        // 시스템 관리자 ? -> 전체 조회 가능
        if(this.isSystemAdmin()){
            queryParam = {"bestInspctInsttAt": "Y"};
        
        } else if (this.isBplcAdmin()) { // 사업장 관리자 ? -> rdmsip ture만 가능
            queryParam = {"bestInspctInsttAt": "Y", isRdmsIp: this.isRdmsIp()};
            
        } else if (this.isGeneralOrCustomer()) { // 일반, 고객사 사용자 ? -> 자기 사업장만 조회 가능
            queryParam = {"bestInspctInsttAt" : "Y", "bestInspctInsttCode" : this.userBplcCode};
        }
        
        // 사용자 메뉴이면서 관리자 권한이 아닐경우 자신의 사업장 데이터만 볼 수 있도록. parameter 변경
        if( this.isUserMenu() && !this.isSystemAdmin() ){
            queryParam =  {"bestInspctInsttAt" : "Y", "bestInspctInsttCode" : this.userBplcCode};
        } else if (this.isPrductMenuUrl()) { // 자재관리 화면 ? -> rdmsIp true만 가능
            queryParam = {"bestInspctInsttAt": "Y", isRdmsIp: this.isRdmsIp()};
        }
        
        return queryParam;
    };

    /*
        조회된 사업장 중에서 현재 user session의 사업장 코드와 맞는 사업장이 있는지 찾는다.
        찾아서 없으면 첫번째 value return. undefined되어 전체 조회되는 행위 방지
     */
    this.findByBplcCode = function (codeList) {
        var findCode = codeList.filter(function (codeObj) {
            return codeObj.value === this.userBplcCode;
        }, this);
        
        return ( findCode.length > 0 ) ? this.userBplcCode : (codeList.length === 0) ? "" : codeList[0].value;
    };

    // 권한에 따른 option disable처리
    this.optionDisable = function (selectbox) {
        for (var i = 0; i < selectbox.length; i++) {
            var option = selectbox[i];
            if (option.selected === false &&        // 현재 user session 사업장이 set되어 선택되어있지 않은 option들
                !this.isSystemAdmin() &&            // 시스템 관리자 아니면
                !this.isBplcAdmin() &&              // 사업장 관리자 아니면
                this.menuUpperpath !== "/src") {    // 조회 메뉴 (대메뉴) 아니면
                
                option.disabled = true;
            }
        }
    };

    // 권한을 적용 사업장 select box 생성 및 option disable 처리 
    this.setBplcCodes = function () {

        // this bind
        var thiz = this;
        
        var bplcObject = this.getBplcElements();
        if (bplcObject.keyType === 'name' && bplcObject.element.length > 0) {
            return ajaxJsonComboTrgetName({
                url: "/com/getDeptCombo.lims",
                name: this.BPLC_KEY,
                queryParam: this.createQueryParam(),
                selectFlag : this.isSystemAdmin()
            }).then(function (data) {
                for (var i = 0; i < bplcObject.element.length; i++) {
                    var bplcElement = bplcObject.element[i];
                    if (!!!bplcElement) {
                        return false;
                    }
                    bplcElement.value = thiz.findByBplcCode(data); // 현재 session의 사업장 코드와 맞는 사업장이 없으면 빈 문자열 set.
                    thiz.optionDisable(bplcElement); // option disable
                }
            });
            
        } else if (bplcObject.keyType === 'id') {

            var bplcElement = bplcObject.element;
            if (!!!bplcElement) {
                return false;
            }
            
            return ajaxJsonComboBox("/com/getDeptCombo.lims", this.BPLC_KEY, this.createQueryParam(), this.isSystemAdmin()).then(function (data) {
                bplcElement.value = thiz.findByBplcCode(data); // 현재 session의 사업장 코드와 맞는 사업장이 없으면 빈 문자열 set.
                thiz.optionDisable(bplcElement); // option disable
            });
        }
    };
}

/**
 * 
 * selectbox관련 util function들을 제공한다.
 * 
 * @param element. javascript element 객체
 * @constructor
 * @author shs
 */
function SelectBoxControll(element) {

    this.element = element;

    this.notSelectedOptionDisable = function (disableOption) {
        this.optionDisableClear();
        
        var options = this.element.options;
        for (var i = 0; i < options.length; i++) {
            var option = options[i];
            if (!option.selected) {
                option.disabled = disableOption;
            }
        }
    };

    this.optionDisableClear = function () {
        var options = this.element.options;
        for (var i = 0; i < options.length; i++) {
            options[i].disabled = false;
        }
    };
}

function ajaxJsonCheckBoxCommon(upperCmmnCode, obj, checkName) {
	obj = obj[0] == "#" ? obj.slice(1) : obj;
	return customAjax({
		url : '/com/getCmmnCode.lims'
		,data : {"upperCmmnCode" : upperCmmnCode}
        ,showLoading : false
		,successFunc : function(data){
			obj = document.getElementById(obj);

			if(!!obj){
				if(data.length != 0){
					for( i in data){
						var label = document.createElement("label");
						var input = document.createElement("input");
						input.type = "checkbox";
						input.value = data[i].value;
						input.id = checkName + i;
						input.name = checkName;
						input.style.width = "14px";
						input.style.height = "12px";
						input.style.marginLeft = "14px";
						label.appendChild(input);
						label.innerHTML += "<span id='"+ "lbl"+ checkName + i +"'>" + data[i].key + "</span>";
						obj.appendChild(label);
					}
				} else {
					obj.innerHTML = "";
				}
			}
		}
	});
}


function ajaxJsonForm(url, formId, successfunction, errorfunction, completefunction) {
	var param;

	if($("input:text[numberOnly]").length != 0)
		$("input:text[numberOnly]").val($("input:text[numberOnly]").val().replaceAll(',',''));

	formId = typeof formId != "string" ? undefined : formId[0] == "#" ? formId : "#"+formId;
	param = $(formId).serializeObject();
	return customAjax({"url" : url, "data" : param, "successFunc" : successfunction, "errorFunc" : errorfunction, "completeFunc" : completefunction, "showLoading" : true});
}

function ajaxJsonFormFile(url, formData, successfunction, errorfunction, completefunction) {

	$.ajax({
        url : url,
        type: "post",
        async: "true",
        data : formData,
        processData : false,
        contentType : false,
        beforeSend : function(xmlHttpRequest){
            xmlHttpRequest.setRequestHeader("AJAX", "true"); // ajax 호출을  header에 기록
        },
        success : function(data,status,request){
        	if(successfunction != undefined && successfunction != null)
        		successfunction(data);
        },
        error : function(request,status,error) {
        	if(request.status == 401) {
        		err("다시 로그인하여야 합니다.");
        		document.location.href="/logout.do";
        	} else {
        		if(request.responseText != undefined){
        			var errorlog = JSON.parse(request.responseText);
        			err("요청이 중단되었습니다. (" + errorlog.error.excpLogSeqno + ")\n");
        		}
        	}
        	if(errorfunction != undefined && errorfunction != null)
        		errorfunction(request,status,error);
        }
	});
}

function comboAjaxJsonParam(url, param, successfunction, completefunction, async) {

	async != undefined ? async = async : async = true

	return $.when($.ajax({
		url : url,
        method: "post",
        type: "json",
        async: async,
        contentType: "application/json; charset=utf-8",
        data : JSON.stringify(param),
        beforeSend : function(xmlHttpRequest){
            xmlHttpRequest.setRequestHeader("AJAX", "true"); // ajax 호출을  header에 기록
            xmlHttpRequest.setRequestHeader("Async", "true");
        },
        complete : function(request,status) {
        	if(completefunction != undefined && completefunction != null)
        		completefunction(request,status);
        }
	})).done(function(data,status,request){
		if(successfunction != undefined && successfunction != null)
    		successfunction(data);
	}).fail(function(request,status,error) {
		if(request.status == 401) {
    		err("다시 로그인하여야 합니다.");
    		document.location.href="/logout.lims";
    		throw "Request failed.";
    	} else if(request.status == 404){
    		err("요청하신 주소를 찾을 수 없습니다.");
    	} else {
    		if(request.responseText != undefined){
    			var errorlog = JSON.parse(request.responseText);
    			$(".wrap-loading").hide(); // 로딩 스타일 함수 숨기기
    			err("요청이 중단되었습니다. System 로그를 확인 하십시오. (" + errorlog.error.excpLogSeqno + ")") ;
    			throw "Request failed.";
    		}
    	}
	});
}

/**
 * @param url : url
 * @param obj : id
 * @param param : object
 * @param flag : 선택 option 추가
 * @param msg : 선택 대신 메시지 추
 * @param selectVal : 빌드후 특정 값 셀렉트
 * @param auth : 권한 적용시 selectbox option들 disabled.
 * @param successfunc : 성공 시 콜백 함수
 */
function ajaxJsonComboBox(url, obj, param, flag, msg, selectVal, auth, successfunc) {
	obj = obj[0] == "#" ? obj.slice(1) : obj;

	return customAjax({
		"url" : url,
		"data" : param,
        "showLoading" : false,
		"successFunc" : function(data){
			obj = document.getElementById(obj);
			if(!!obj){
				for(var i = obj.options.length - 1 ; i >= 0 ; i--)
					obj.remove(i);

				if(flag){
					var op = new Option();
					op.value = '';
					op.text = '선택';
					op.selected = true;
					obj.options.add(op);
				} else if(flag == false && msg != undefined){
					var op = new Option();
					op.value = '';
					op.text = msg;
					op.selected = true;
					obj.options.add(op);
				}

				if(auth != undefined){
					if (auth == "SY09000001" || !auth)
						$('#'+obj + ' option').not(':selected').prop('disabled', false);
					else
						$('#'+obj + ' option').not(':selected').prop('disabled', true);
				}

				if(data.length != 0){
					for( i in data){
						var text = "";
						var cnt = 0;
						if(!!data[i] && !!data[i].level){
							for(cnt=0; cnt < data[i].level * 1 ; cnt++){
								text +="　";
							}

							if(cnt !=0)
								text +="└";
						}

						var op = new Option();
						op.value = data[i].value;
						op.text = text + data[i].key;
						obj.options.add(op);
						text = "";
						cnt = 0;
					}
				}
			}

			if(successfunc != undefined && successfunc != null && typeof successfunc === "function") {
				successfunc(data);
			}

			// selectVal 기능추가 210514 jjw
			if(selectVal == undefined ||selectVal == ""){
			}
			else{
				for( var i = 0 ; i < obj.childElementCount ; i++){
				if(obj[i].value == selectVal){
					$('#'+obj.id + ' option')[i].selected = true;
					}
				}
			}
		}
	});
}

/**
 * @param {Object} param {
 *      {string} url            : url
 *      {string} name           : selectbox name. not id !!
 *      {Object} queryParam     : query parameter
 *      {Boolean} selectFlag    : 선택 넣을지 말지 flag
 *      {string} msg            : 선택 대신에 넣을 custom msg
 *      {string} selectVal      : selectbox option load 이후 set할 값
 *      {string} auth           : 권한 공통코드
 *      {Function} successfunc  : 성공시 function
 * }
 */
function ajaxJsonComboTrgetName(param) {
    
    var url = param.url;
    var name = param.name;
    var queryParam = param.queryParam;
    var selectFlag = (param.selectFlag !== false);
    var msg = param.msg;
    var selectVal = param.selectVal;
    var auth = param.auth;
    var successfunc = param.successfunc;

    return customAjax({
        "url": url,
        "data": queryParam,
        "showLoading": false,
        "successFunc": function (data) {
            var selectboxes = document.querySelectorAll('select[name=' + name + ']');
            if (selectboxes.length > 0) {
                for (var k = 0; k < selectboxes.length; k++) {
                    var obj = selectboxes[k];
                    if (!!obj) {
                        for (var i = obj.options.length - 1; i >= 0; i--) {
                            obj.remove(i);
                        }

                        if (selectFlag) {
                            var op = new Option();
                            op.value = '';
                            op.text = '선택';
                            op.selected = true;
                            obj.options.add(op);
                        } else if (selectFlag === false && msg !== undefined) {
                            var op = new Option();
                            op.value = '';
                            op.text = msg;
                            op.selected = true;
                            obj.options.add(op);
                        }
                        
                        if (data.length !== 0) {
                            for (i in data) {
                                var text = "";
                                var cnt = 0;
                                if (!!data[i] && !!data[i].level) {
                                    for (cnt = 0; cnt < data[i].level * 1; cnt++) {
                                        text += "　";
                                    }

                                    if (cnt !== 0)
                                        text += "└";
                                }

                                var op = new Option();
                                op.value = data[i].value;
                                op.text = text + data[i].key;
                                obj.options.add(op);
                                text = "";
                                cnt = 0;
                            }
                        }
                        
                        if (!!selectVal) {
                            obj.value = selectVal;
                        }
                        
                        if (auth !== undefined) {
                            optionDisable(obj, auth);
                        }
                    }

                    if (typeof successfunc === "function") {
                        successfunc(data);
                    }
                }
            }
        }
    });

    function optionDisable(selectbox, auth) {
        for (var i = 0; i < selectbox.length; i++) {
            var option = selectbox[i];
            if (auth === "SY09000001" && option.selected === false) {
                option.disabled = false;
            } else if (auth !== "SY09000001" && option.selected === false) {
                option.disabled = true;
            }
        }
    }
}

/**
 *
 * @param gridID : grid ID
 * @param msg : 파일 명
 */
function excelExport(gridID, msg){
	var today = new Date(); var dd = today.getDate(); var mm = today.getMonth()+1; var yyyy = today.getFullYear(); var hh = today.getHours(); var mm = today.getMinutes(); var ss = today.getSeconds(); var ms = today.getMilliseconds();
	if(dd<10)
	    dd='0'+dd;
	if(mm<10)
	    mm='0'+mm;
	today = '_'+yyyy+mm+dd+hh+mm+ss+ms;
	var exportProps = {
		fileName : msg + today,	// 저장하기 파일명  + 현재날짜붙임
		exportWithStyle : true,
		exceptColumnFields : ["checkBox"]
	};
	// 로컬 다운로드 가능 여부 ie 9 이상이면 filesaver.min.js 태움. / 그이하면 excelExport.jsp로 보냄.
	if(!AUIGrid.isAvailableLocalDownload(gridID)) // IE 버전체크
		AUIGrid.setProp(gridID, "exportURL", "/excelExport.jsp"); // HTML5를 완전히 지원하지 않는 브라우저는 서버로 전송하여, 다운로드 처리.
	// 내보내기 실행
	else
		AUIGrid.exportToXlsx(gridID, true, exportProps);
}

/**
 * 동기 방식 Ajax
 */
function rdmsViwerAction(resultObj, rdmsGbn, s, page) {
	var url = "/com/rdmsViewer.lims";
	var ret = null;
	$.ajax({
		url : url,
		dataType : 'json',
		type : 'POST',
		async : false,
		contentType: "application/json; charset=utf-8",
        data : JSON.stringify(resultObj),
		success : function(data) {
			if (data == null || data[1] == 0) {
				warn('데이터가 존재하지 않습니다.');
			} else {
				document.getElementById("vParam").value = data[1];
				if (mobileCheck()){
					var w = window.screen.width / 1.5; // 팝업창 가로길이
					var h = window.screen.height / 1.5; // 팝업창 세로길이

					var l = (window.screen.width / 2) - ((w / 2) + 10);
					var t = (window.screen.height / 2) - ((h / 2) + 50);
					window.open('http://' + data[0] + '/RDMS_ViewerRun/RDMS_ViewerRun.application?vParam=' + data[1],"rdmsViewer",'width='+w+',height='+h+',top='+t+',left='+l);
				}else{
					var frm = document.getElementById("frmRDMSView");
					frm.action = 'http://' + data[0] + '/RDMS_ViewerRun/RDMS_ViewerRun.application';
					frm.submit();
				}
			}
		},
		error : function() {
			warn('RDMS 뷰어 오류가 발생했습니다.');
		}
	});
	return ret;
}

/**
 * 한 자리 숫자에 '0' 채우기
 */
function zeroPad(num) {
	num = String(num);
    return num.length < 2 ? '0' + num : num;
}

/**
 * 날짜 구하기
 */
function getFormatDate(yy,mm,dd){
	 var date = new Date();

	 yy = yy || 0;
	mm = mm || 0;
	dd = dd || 0;
	var YY = new Date(date.getFullYear()+yy, date.getMonth()+mm, date.getDate()+dd).getFullYear();
	var MM = zeroPad(new Date(date.getFullYear()+yy, date.getMonth()+mm, date.getDate()+dd).getMonth()+1);
	var DD = zeroPad(new Date(date.getFullYear()+yy, date.getMonth()+mm, date.getDate()+dd).getDate());

	return YY + "-" + MM + "-" + DD;
}
/**
 * getFormatDate(yy,mm,dd) 호출 함수
 */
function getFormatDateTime(yy,mm,dd,hh,mi,ss){
	 var date = new Date();
	yy = yy || 0;
	mm = mm || 0;
	dd = dd || 0;
	hh = hh || 0;
	mi = mi || 0;
	ss = SS || 0;
	var YY = new Date(date.getFullYear()+yy, date.getMonth()+mm, date.getDate()+dd,date.getHours()+hh,date.getMinutes()+mi,date.getSeconds()+ss).getFullYear();
	var MM = zeroPad(new Date(date.getFullYear()+yy, date.getMonth()+mm, date.getDate()+dd,date.getHours()+hh,date.getMinutes()+mi,date.getSeconds()+ss).getMonth()+1);
	var DD = zeroPad(new Date(date.getFullYear()+yy, date.getMonth()+mm, date.getDate()+dd,date.getHours()+hh,date.getMinutes()+mi,date.getSeconds()+ss).getDate());
	var HH = zeroPad(new Date(date.getFullYear()+yy, date.getMonth()+mm, date.getDate()+dd,date.getHours()+hh,date.getMinutes()+mi,date.getSeconds()+ss).getHours());
	var MI = zeroPad(new Date(date.getFullYear()+yy, date.getMonth()+mm, date.getDate()+dd,date.getHours()+hh,date.getMinutes()+mi,date.getSeconds()+ss).getMinutes());
	var SS = zeroPad(new Date(date.getFullYear()+yy, date.getMonth()+mm, date.getDate()+dd,date.getHours()+hh,date.getMinutes()+mi,date.getSeconds()+ss).getSeconds());
	return YY + "-" + MM + "-" + DD+" "+HH+":"+MI+":"+SS;
}
function getYYMMDD(etc,flag){
	var arr = [];
	if(typeof etc == "number" || typeof etc == "string") //단일 값이 넘어왔다면
		arr.push(etc);
	else if($.isArray(etc)) //배열로 넘겨줬을 때
		arr = etc;

	switch(flag.toUpperCase()){
	case "YY":
		return getFormatDate(arr[0]);
		break;
	case "MM":
		return getFormatDate(null,arr[0]);
		break;
	case "DD":
		return getFormatDate(null,null,arr[0]);
		break;
	default :
			return getFormatDate(arr[0],arr[1],arr[2]);
		break;
	}
}

/**
 * 매월의 첫 날 일자 혹은 마지막 날 일자 구하기
 */
function getFLDay(dt,flag){
	var dtArr = dt.split("-");
	switch(flag.toUpperCase()){
	case "F" :
		return dtArr[0] + "-" + dtArr[1] + "-" + zeroPad(new Date(dtArr[0],dtArr[1]-1,1).getDate()); //월의 첫째날
		break;
	case "L" :
		return dtArr[0] + "-" +dtArr[1] +  "-" + zeroPad(new Date(dtArr[0],dtArr[1],0).getDate()); //월의 마지막날
		break;
    case "YF" :
        return dtArr[0] + "-" + zeroPad(new Date(dtArr[0],1,1).getMonth()) + "-" + zeroPad(new Date(dtArr[0],1,1).getDate()); //년의  첫째날
        break;
    case "YL" :
        return dtArr[0] + "-" + zeroPad(new Date(dtArr[0],12,0).getMonth()+1) +  "-" + zeroPad(new Date(dtArr[0],12,0).getDate()); //년의 마지막날
        break;
	}
}

// 달력 스타일 동적 변경 (기존 탭과 겹치던 현상 개선.)
function calendarStyle(){
	var style = document.createElement('style');
	 style.type = 'text/css';
	 style.innerHTML = ".ui-datepicker{z-index:1950!important;}";
	 document.body.appendChild(style);
}

/**
 * @param dateSelectors 선택가능일 제한 O  (ex: datePickerCalendar(["datepicker1","datepicker2"]);
								 선택가능일 제한 X  (ex: datePickerCalendar([false,"datepicker3","datepicker4"]);
 * @param defaultValue   기본값 설정 여부 ( true / false )
 * @param beforeDays 	 첫번 째 datepicker에 년 월 일 중 하나를 얼마나 수정할지 ( ["YY",-1 ] = 1년 전 날짜
								 ["MM", -24, first"] = 2년 전 현재 월의 첫 날 일자 )
								 ["MM", 9, first"] = 9개월 후의 마지막 날 일자 )
 * @param afterDays 		 두번 째 datepicker 세팅 옵션 ( beforeDays와 동일 )
 * 예제)  mat/EtHdayM.jsp  참고 ( http://localhost:8080/mat/EtHdayM.ak )
 */
//달력, <input type="text" id="datepicker1">
function datePickerCalendar(dateSelectors,defaultValue,beforeDays,afterDays, etcFunc, onSelect){
	var props = {};
 	/*var date = new Date();
    var today = new Date(Date.parse(date));
    var hh = today.getHours();
    var mi = today.getMinutes();
    var ss = today.getSeconds();*/

	props.dateFormat = "yy-mm-dd";
	props.showOtherMonths = true;
	props.selectOtherMonths = true;
	props.monthNames =  ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
	props.monthNamesShort = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
	props.dayNames = ['일', '월', '화', '수', '목', '금', '토'];
	props.dayNamesShort = ['일', '월', '화', '수', '목', '금', '토'];
	props.dayNamesMin = ['일', '월', '화', '수', '목', '금', '토'];
	props.showMonthAfterYear = true;
	props.changeMonth = true;
	props.changeYear = true;
	if(!!onSelect)
		props.onSelect = onSelect;

	if(dateSelectors != undefined && dateSelectors.length > 0){
		if(dateSelectors[0] == false || dateSelectors.length != 2){ //선택제한을 하지 않음 (ex: datePickerCalendar([false,"datepicker3","datepicker4"]);
			for(var i in dateSelectors){
                setDatePicker(dateSelectors[i]);
			}
		}else if(dateSelectors.length == 2){ //선택제한(최소일 ,최대일) 세팅 (ex: datePickerCalendar(["datepicker1","datepicker2"]);
			if(dateSelectors[0] !== undefined){
                setDatePicker(dateSelectors[0]);
			}
			if(dateSelectors[1] !== undefined){
                setDatePicker(dateSelectors[1]);
			}
		}

		if(defaultValue == true){//datePicker에 기본값 입력할 지
			defaultCalendar(dateSelectors[0],dateSelectors[1],beforeDays,afterDays);
		}

		if(etcFunc != undefined)
			etcFunc();
	}

	// 달력 스타일 동적 지정
	calendarStyle();

    function setDatePicker(idOrName) {
        var $el = $("#" + idOrName).length > 0 ? $("#" + idOrName) : $("input[name="+ idOrName +"]");
        if ($el.length > 0) {
            $el.datepicker(props);
        }
    }
}


/**
 * datePicker에 기본값 입력
 */
function defaultCalendar(datePickerId1,datePickerId2,beforeDays,afterDays){
    
    var $el = $("#"+datePickerId1).length > 0 ? $("#"+datePickerId1) : $("input[name="+ datePickerId1 +"]")
    var $el2 = $("#"+datePickerId2).length > 0 ? $("#"+datePickerId2) : $("input[name="+ datePickerId2 +"]")
    
    $el.val("");
    $el2.val("");

    var date = new Date();
    var today = getFormatDate();  //앞 datepicker에 세팅할 현재 날짜(기본 세팅값)
    var t_today = getFormatDate();  //뒤 datepicker에 세팅할 현재 날짜(기본 세팅값)
    var validator = function(arg){
    	if(arg != undefined){
    		arg =  String(arg);
	    	if(typeof arg == "string" && arg.toUpperCase() == "FIRST")
	    		return true;
	    	else if(typeof arg == "string" && arg.toUpperCase() == "LAST")
	    		return false;
    	}
    }

    //옵션이 있다면 datePicker 시작일 값 세팅
    if(beforeDays != undefined && beforeDays.length != 0){
    	switch(beforeDays[0].toUpperCase()){
    	case 'YY' :
            if(validator(beforeDays[2])){
                today = getFLDay(getYYMMDD(beforeDays[1],"YY"),"YF"); //해당 월의 첫째일 설정
            }
            else if(validator(beforeDays[2]) == false)
                today = getFLDay(getYYMMDD(beforeDays[1],"YY"),"YL"); //해당 월의 마지막일 설정
            else
                today = getYYMMDD(beforeDays[1],"YY");
            break;
    	case 'MM' :
    		if(validator(beforeDays[2])){
    			today = getFLDay(getYYMMDD(beforeDays[1],"MM"),"F"); //해당 월의 첫째일 설정
    		}
    		else if(validator(beforeDays[2]) == false)
    			today = getFLDay(getYYMMDD(beforeDays[1],"MM"),"L"); //해당 월의 마지막일 설정
    		else
    			today = getYYMMDD(beforeDays[1],"MM");
    		break;
    	case 'DD' :
    		today = getYYMMDD(beforeDays[1],"DD");
    		break;
    	case 'HMS' :
    		today = getYYMMDD(beforeDays[1],"DD");
    		break;
    	}
    }
    //옵션이 있다면 datePicker 종료일 값 세팅
    if(afterDays != undefined && afterDays.length != 0){
    	switch(afterDays[0].toUpperCase()){
    	case 'YY' :
            if(validator(afterDays[2])){
                t_today = getFLDay(getYYMMDD(afterDays[1],"YY"),"YF"); //해당 월의 첫째일 설정
            }
            else if(validator(afterDays[2]) == false)
                t_today = getFLDay(getYYMMDD(afterDays[1],"YY"),"YL"); //해당 월의 마지막일 설정
            else
                t_today = getYYMMDD(afterDays[1],"YY");
            break;
    	case 'MM' :
    		if(validator(afterDays[2]))
    			t_today = getFLDay(getYYMMDD(afterDays[1],"MM"),"F");
    		else if(validator(afterDays[2]) == false)
    			t_today = getFLDay(getYYMMDD(afterDays[1],"MM"),"L");
    		else
    			t_today = getYYMMDD(afterDays[1],"MM");
    		break;
    	case 'DD' :
    		t_today = getYYMMDD(afterDays[1],"DD");
    		break;
    	}
    }

    $el.val(today);
    $el2.val(t_today);
}

function dateTimePickerCalendar(dateSelectors,defaultValue,beforeDays,afterDays, etcFunc){
	var props = {};

	 props.dateFormat='yy-mm-dd';
	 props.monthNamesShort=[ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ];
	 props.dayNamesMin=[ '일', '월', '화', '수', '목', '금', '토' ];
	 props.changeMonth=true;
	 props.changeYear=true;
	 props.showMonthAfterYear=true;

	 // timepicker 설정
	 props.timeFormat='HH:mm:ss';
	 props.controlType='select';
	 props.oneLine=true;
//
	if(dateSelectors != undefined && dateSelectors.length > 0){
		if(dateSelectors[0] == false || dateSelectors.length != 2){ //선택제한을 하지 않음 (ex: datePickerCalendar([false,"datepicker3","datepicker4"]);
			for(var i in dateSelectors){
				$("#"+dateSelectors[i]).datetimepicker(props);
			}
		}else if(dateSelectors.length == 2){ //선택제한(최소일 ,최대일) 세팅 (ex: datePickerCalendar(["datepicker1","datepicker2"]);
			if(dateSelectors[0] !== undefined){
				props.onClose = function ( selectedDate ) {
			        $("#"+dateSelectors[1]).datetimepicker("option", "minDate", selectedDate);
				};
				$("#"+dateSelectors[0]).datetimepicker(props);
			}
			if(dateSelectors[1] !== undefined){
				props.onClose = function ( selectedDate ) {
				    $("#"+dateSelectors[0]).datetimepicker("option", "maxDate", selectedDate);
				};
				$("#"+dateSelectors[1]).datetimepicker(props);
			}
		}

		if(defaultValue == true){//datetimepicker에 기본값 입력할 지
			defaultTimeCalendar(dateSelectors[0],dateSelectors[1],beforeDays,afterDays);
		}

		if(etcFunc != undefined)
			etcFunc();
	}

}

function defaultTimeCalendar(datePickerId1,datePickerId2,beforeDays,afterDays){
    $("#"+datePickerId1).val("");
    $("#"+datePickerId2).val("");

    var date = new Date();
    var today = getFormatDate();  //앞 datepicker에 세팅할 현재 날짜(기본 세팅값)
    var t_today = getFormatDate();  //뒤 datepicker에 세팅할 현재 날짜(기본 세팅값)
    var validator = function(arg){
    	if(arg != undefined){
    		arg =  String(arg);
	    	if(typeof arg == "string" && arg.toUpperCase() == "FIRST")
	    		return true;
	    	else if(typeof arg == "string" && arg.toUpperCase() == "LAST")
	    		return false;
    	}
    }

    //옵션이 있다면 datePicker 시작일 값 세팅
    if(beforeDays != undefined && beforeDays.length != 0){
    	switch(beforeDays[0].toUpperCase()){
    	case 'YY' :
            if(validator(beforeDays[2])){
                today = getFLDay(getYYMMDD(beforeDays[1],"YY"),"YF"); //해당 월의 첫째일 설정
            }
            else if(validator(beforeDays[2]) == false)
                today = getFLDay(getYYMMDD(beforeDays[1],"YY"),"YL"); //해당 월의 마지막일 설정
            else
                today = getYYMMDD(beforeDays[1],"YY");
            break;
    	case 'MM' :
    		if(validator(beforeDays[2])){
    			today = getFLDay(getYYMMDD(beforeDays[1],"MM"),"F"); //해당 월의 첫째일 설정
    		}
    		else if(validator(beforeDays[2]) == false)
    			today = getFLDay(getYYMMDD(beforeDays[1],"MM"),"L"); //해당 월의 마지막일 설정
    		else
    			today = getYYMMDD(beforeDays[1],"MM");
    		break;
    	case 'DD' :
    		today = getYYMMDD(beforeDays[1],"DD");
    		break;
    	case 'HMS' :
    		today = getYYMMDD(beforeDays[1],"DD");
    		break;
    	}
    }
    //옵션이 있다면 datePicker 종료일 값 세팅
    if(afterDays != undefined && afterDays.length != 0){
    	switch(afterDays[0].toUpperCase()){
    	case 'YY' :
    		t_today = getYYMMDD(afterDays[1],"YY");
    		break;
    	case 'MM' :
    		if(validator(afterDays[2]))
    			t_today = getFLDay(getYYMMDD(afterDays[1],"MM"),"F");
    		else if(validator(afterDays[2]) == false)
    			t_today = getFLDay(getYYMMDD(afterDays[1],"MM"),"L");
    		else
    			t_today = getYYMMDD(afterDays[1],"MM");
    		break;
    	case 'DD' :
    		t_today = getYYMMDD(afterDays[1],"DD");
    		break;
    	}
    }
    $("#"+datePickerId1).val(today + " 00:00:00");
    $("#"+datePickerId2).val(t_today + " 00:00:00");
}


//그리드 드랍다운 리스트
function getGridComboList(url, param, bChoice) {
	var array = new Array();
	if (bChoice != undefined && bChoice){
		array.push({key : lang.C000000079, value : ""});	/*선택*/
	}

	customAjax({
		"url" : url,
		"data" : param,
        "async" : false,
        "showLoading" : false,
		"successFunc" : function(data){
			$(data).each(function(index, entry) {
				array.push(entry);
			});
		}
	});
	return array;
}

/**
 * RDMS 뷰어 호출 함수
 * @param gridId, gbn
 * gbn = 1 // 의뢰일련번호: reqestSeqno
 * gbn = 2 // 시험항목일련번호: reqestExpriemSeqno
 *  기본 조건: 그리드 SELECT 조건으로
 *  reqestSeqno, reqestExpriemSeqno, 데이터 필수
 */

function openRDMSViewer(gridId, gbn, s, page){

	// S : 1 원본 , 2: 복사본

	var getCheckedData = AUIGrid.getCheckedRowItems(gridId);
	var arrData =  new Array();
	var exprOdrArr =  new Array();//차수 담을 배열
	var binderArr = new Array();//binderitemvalue_id 담을 배열
	var key3Arr = new Array();//key3조합 담을 배열

	var resultObj = new Object();//최종 결과값으로 매퍼에 보낼 객체

	resultObj["rdmsGbn"] = gbn;
	resultObj["showGbn"] = s;
	resultObj["page"] = page;

	if(gbn == 1){//의뢰별 뷰어 조회
		if(getCheckedData.length == 0){
			warn(lang.C000001248) /*"선택한 의뢰가 없습니다. 의뢰를 선택해 주세요."*/
			return false;
		} else {
			for(var i=0; i<getCheckedData.length; i++){
				arrData[i] = getCheckedData[i].item.reqestSeqno;
			}
			resultObj["gridData"] = arrData;
//			callRDMSViwer(resultObj);
		}
	} else if(gbn == 2){
		if(getCheckedData.length == 0){
			warn("선택된 항목이 없습니다.");
		}else{
			for(var i = 0 ; i <  getCheckedData.length; i++){
				var obj = new Object();
				var row = getCheckedData[i].item;
				if(!!row.reqestExpriemSeqno){
					arrData.push(row.reqestExpriemSeqno);
					arrData.push(row.exprOdr);
				}

			}
			resultObj["gridData"] = arrData;
//			callRDMSViwer(resultObj);
		}
	}

}

//
//function html5Viewer(fileNm, arrayData){
//
//	var viewerParam = {};
//
//	customAjax({
//		"url" : "/com/html5Viewer.lims",
//		"data" : viewerParam,
//		"successFunc" :  function(data){
//			var serverUrl = data.reportingServerPath;
//			var filePath = data.rdPath;
//			var openParam = {};
//			var openArray = [];
//			var forInt = 0;
//
//			for(var i=0; i<arrayData.length; i++){
//
//				openParam = {};
//				openParam.mrdPath = filePath + fileNm;
//				openParam.mrdParam = data.loginParameter + " /rp " + arrayData[i];
//				openArray[forInt] =  openParam;
//				forInt ++;
//			}
//			viewerFunc(serverUrl, openArray);
//		}
//	});
//}

function html5Viewer(fileArr, parameterArr1, parameterArr2, parameterArr3, parameterArr4, parameterArr5, parameterArr6, parameterArr7, parameterArr8) {

    customAjax({
		"url" :"/com/html5Viewer.lims",
		"data": {},
        "showLoading" : false,
		"successFunc": function(data) {
            var reportingServerPath = data.reportingServerPath;
            var loginParameter = data.loginParameter;
   		var filePath = data.fileUrl; //프로젝트 위험요소 이미지 경로
//             var filePath = "D:/was/apache-tomcat-8.5.70_LIMS/webapps/ROOT"; // 운영서버 root경로

            var paramArr1 = new Array();
            var paramArr2 = new Array();

            var paramArr3 = new Array();
            var paramArr4 = new Array();
            var paramArr5 = new Array();
            var paramArr6 = new Array();
            var paramArr7 = new Array();
            var paramArr8 = new Array();

            var paramArr9 = new Array(); // filepath로 사용

            if (parameterArr1 != undefined) {
                paramArr1 = parameterArr1;
            }
            if (parameterArr2 != undefined) {
                paramArr2 = parameterArr2;
            }
            if (parameterArr3 != undefined) {
                paramArr3 = parameterArr3;
            }
            if (parameterArr4 != undefined) {
                paramArr4 = parameterArr4;
            }
            if (parameterArr5 != undefined) {
                paramArr5 = parameterArr5;
            }
            if (parameterArr6 != undefined) {
                paramArr6 = parameterArr6;
            }
            if (parameterArr7 != undefined) {
                paramArr7 = parameterArr7;
            }
            if (parameterArr8 != undefined) {
                paramArr8 = parameterArr8;
            }
            paramArr9[0] = filePath;

            var mrdList = new Array();

            if (fileArr.length == 1) {
                mrdList[0] = {
                    mrdPath: data.rdPath+"/"+fileArr[0],
                    mrdParam: loginParameter+" /rp "+"["+paramArr1+"]"+" ["+paramArr2+"]"+" ["+paramArr3+"]"+" ["+paramArr4+"]"+" ["+paramArr5+"]"+" ["+paramArr6+"]"+" ["+paramArr7+"]"+" ["+paramArr8+"]"+" ["+paramArr9+"]"
                };

            } else {
                for (var i = 0; i < fileArr.length; i++) {
                    mrdList[i] = {
                        mrdPath: data.rdPath+fileArr[i],
                                  mrdParam:loginParameter+" /rp "+"["+paramArr1[i]+"]"+" ["+paramArr2[i]+"]"+" ["+paramArr3[i]+"]"+" ["+paramArr4[i]+"]"+" ["+paramArr5[i]+"]"+" ["+paramArr6[i]+"]"+" ["+paramArr7[i]+"]"+" ["+paramArr8[i]+"]"+" ["+paramArr9[0]+"]"
                    };
                }
            }

            viewerFunc(reportingServerPath, mrdList);
		}
	});
}

//pA : Parameter Array
function html5ViewerRequest(fileArr, pA1, pA2){
    customAjax({
        "url" :"/com/html5Viewer.lims",
        "data": {},
        "showLoading" : false,
        "successFunc": function(data){
            var reportingServerPath = data.reportingServerPath;
            var loginParameter = data.loginParameter;
            var filePath = "D:/was/apache-tomcat-8.5.70_LIMS/webapps/ROOT"; //운영서버 root경로
            var mrdList = new Array();
            if (fileArr.length == 1) {
                mrdList[0] = {
                    mrdPath : data.rdPath+fileArr[0],
                    mrdParam : loginParameter + " /rp " + "[" + pA1 + "]" + " [" + pA2 + "]" + " [][][][][][]" + " [" + filePath + "]"
                };
            } else {
                for(var i = 0; i < fileArr.length; i++){
                    mrdList[i] = {
                        mrdPath : data.rdPath+fileArr[i],
                        mrdParam : loginParameter + " /rp " + "[" + pA1[i] + "]" + " [" + pA2 + "]" + "[][][][][][]" + " [" + filePath + "]"
                    };
                }
            }
            viewerFunc(reportingServerPath, mrdList);
        }
    });
}

function viewerFunc(reportingServerPath, mrdList){
	var viewer = new m2soft.crownix.Viewer(reportingServerPath);
	viewer.openFile(mrdList);
	$("#crownix-html5-viewer").css("position","fixed");
}


function html5Viewer2(fileNm, param){
	customAjax({
		"url" : "/com/html5Viewer.lims",
        "showLoading" : false,
		"successFunc" : function(data){
			var serverUrl = data.reportingServerPath;
			var mrdPath = data.rdPath + fileNm;
			var mrdParam = data.loginParameter + " /rp " + param;

			viewerFunc2(serverUrl, mrdPath, mrdParam);
		}
	});
}

/**
 *HTML5 RD viewer
*/
function viewerFunc2(serverUrl, filePath, param){
	var viewer = new m2soft.crownix.Viewer(serverUrl);
	viewer.openFile(filePath, param);
}


//현재 날짜 구하기
function currentDate(type){
	var date = new Date(),
	today = new Date(Date.parse(date)),
	yy = today.getFullYear(),
	mm = today.getMonth()+1,
	dd = today.getDate(),
	hh = today.getHours(),
	min = today.getMinutes(),
	ss = today.getSeconds(),
	result;
	mm = mm < 10 ? "0" + mm : mm;
	dd = dd < 10 ? "0" + dd : dd;
	if(!type){
		result = yy+"-"+mm+"-"+dd;
	}else{
		result = yy+"-"+mm+"-"+dd+' '+hh+':'+min+':'+ss;
	}
	return result;
}

//form serializeObject
function getFormParam(formId){
	if($("input:text[numberOnly]").length != 0)
		$("input:text[numberOnly]").val($("input:text[numberOnly]").val().replaceAll(',',''));

	formId = typeof formId != "string" ? undefined : formId[0] == "#" ? formId : "#"+formId;
	return $(formId).serializeObject();
}

//패스워드 체크 함수 (숫자, 문자, 특수문자 포함 8자리 이상)
// function passwordChk(obj){
// 	var pwdCheck = /^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/
// 	var pwdVal = $("#"+obj).val();
// 	if(!pwdVal.match(pwdCheck)){
// 		warn('숫자, 문자, 특수문자 포함 8자리를 입력해 주세요.');
// 		$('#'+obj).focus();
// 	}
// }


var Cookie = {
		set : function(key, value, days, path){
			if(days == undefined) days = 365;

			var date = new Date();
			date.setTime(date.getTime() + days*24*60*60*1000);

			if(!path) path = "/";

			document.cookie = key + '=' + value + '; expires=' + date.toUTCString() + '; path=' + path;
		},

		get : function(key){
			var value = document.cookie.match('(^|;) ?' + key + '=([^;]*)(;|$)');
		  	return value? value[2] : null;
		},

		remove : function(key){
		  document.cookie = key + '=; expires=0;';
		}

}

//아이템 상태 반환
function getItemState(curItem, grid) {

	var rowIdField = AUIGrid.getProp(grid, "rowIdField");
	var rowIdValue = curItem[rowIdField];

	// 추가된 행인지 여부 검사.
	var isAdded = AUIGrid.isAddedById(grid, rowIdValue );
	if(isAdded) return "Added";

	// 삭제된 행인지 여부 검사
	var isRemoved = AUIGrid.isRemovedById(grid, rowIdValue );
	if(isRemoved) return "Removed";

	// 수정된 행인지 여부 검사
	var isEdited = AUIGrid.isEditedById(grid, rowIdValue );
	if(isEdited) return "Edited";

	return "Normal";
}

//반올림 함수
/*
 * value : 값
 * decimals : 자릿수
*/
function getRound(value, decimals) {
	var result = Number(Math.round(value+'e'+decimals)+'e-'+decimals);
	// 소수점 자릿수 고정을 위해 toFixed
	result = result.toFixed(decimals);

	return result;
}

/*
 * 숫자만 입력
 */
function onlyNumber(obj) {
    $(obj).keyup(function(){
    	this.value = this.value.replace(/[^0-9]/g,'');
    });

    $(obj).blur(function(){
    	this.value = this.value.replace(/[^0-9]/g,'');
    });
}

/**
 * 날짜 하이픈 및 자리수 제한
 * @param obj
 * @returns
 */
function autoHypen(obj) {
	var objT = $("#"+obj.id)[0];

	var str = objT.value;
	var pattern = /[^0-9]/g;

	//숫자와 - 만 입력 받음
	if(pattern.test(str)){
		objT.value = objT.value.replace(/[^0-9-]/g,'');
	}
	else{
		var tmp = "";
		var formatNum = "";

		if(str.length == 8) {
			formatNum = str.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
			objT.value = formatNum;
		}
		else if(str.length > 8){
			var str2 = objT.value.substr(0, 10); //문자열 자르기
			objT.value = str2;
		}
	}
}

/**
 * byte 체크
 * @param obj   - 해당 obj
 * @param byte  - 제한할 byte 수
 * @returns
 */
function fnChkByte(obj, byte) {

	var str = obj.value;
    var maxByte = byte; //최대 입력 바이트 수
    var str_len = str.length;
    var rbyte = 0;
    var rlen = 0;
    var one_char = "";
    var str2 = "";

    for (var i = 0; i < str_len; i++) {
        one_char = str.charAt(i);

        if (escape(one_char).length > 4) {
            rbyte += 2; //한글2Byte
        } else {
            rbyte++; //영문 등 나머지 1Byte
        }

        if (rbyte <= maxByte) {
            rlen = i + 1; //return할 문자열 갯수
        }
    }

    if (rbyte > maxByte) {
    	//alert("한글 " + (maxByte / 2) + "자 / 영문 " + maxByte + "자를 초과 입력할 수 없습니다.", "warning");
        str2 = str.substr(0, rlen); //문자열 자르기
        obj.value = str2;
        fnChkByte(obj, maxByte);
    }
}


//날짜컬럼 정규식을 통하여 벨리데이션 체크
function dateTypeCheck(id, type){

	id = id[0] == "#" ? id : "#"+id;

	var value = $(id).val();
	var pattern = "";
	var bool =  true;

	switch(type){
		case "date":
			//YYYY-MM-DD
			pattern = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;
		break;
		case "dateTime":
			//YYYY-MM-DD HH:MM:SS
			pattern = /^(19[7-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1]) (0[0-9]|1[0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$/;
		break;
	}

	if(value){
		if(pattern.test(value) == false){
			warn("날짜 형식이 맞지 않습니다.");
			$(id).val("");
			bool = false;
		}
	}

	return bool;
}

//날짜 계산
function date_add(sDate, nDays) {

    var yy = parseInt(sDate.substr(0, 4), 10);

    var mm = parseInt(sDate.substr(5, 2), 10);

    var dd = parseInt(sDate.substr(8), 10);

    var d = new Date(yy, mm - 1, dd + parseInt(nDays));

    yy = d.getFullYear();

    mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : mm;

    dd = d.getDate(); dd = (dd < 10) ? '0' + dd : dd;

    return '' + yy + '-' +  mm  + '-' + dd;
}
//왼쪽에서부터 채움
//LPAD('java', '0', 8);                        // 0000java
//숫자인 경우 toString() 사용
function LPAD(s, c, n) {
	 if (! s || ! c || s.length >= n) {
	     return s;
	 }

	 var max = (n - s.length)/c.length;
	 for (var i = 0; i < max; i++) {
	     s = c + s;
	 }

	 return s;
}

//오른쪽에서부터 채움
//RPAD('java', '0', 9);                       // java00000
//숫자인 경우 toString() 사용
function RPAD(s, c, n) {
	 if (! s || ! c || s.length >= n) {
	     return s;
	 }

	 var max = (n - s.length)/c.length;
	 for (var i = 0; i < max; i++) {
	     s += c;
	 }

	 return s;
}

/* 계산식 계산 */
function nomfrmFnCal(sNomfrmFn, iMarkCphr, type){
	type = (!type) ? "nomfrmCn" : type;
	if(!iMarkCphr)
		iMarkCphr = "4";
	
	try{
		var rsltData = eval("(" + sNomfrmFn+")"+".toFixed("+ iMarkCphr +")");
	}catch(e){
		//alert("수식 오류 입니다.\n" + e.message);
		rsltData = "fail";
	};
	return rsltData;
}


//탭 안에 들어있는 그리드 모조리 리사이즈시킴.
function tabGridResize(){
	// 얘네 그리드아님. 모든 탭의 수와 그리드 html 목록을 가져오기위한것임.
	// 탭 리스트
	var tabList = document.getElementsByClassName("tabMenu");
	// 탭안에 들어있는 그리드 리스트
	var gridList = document.getElementsByClassName("grid");

	//getElementById 길어서 그냥 줄였음
	var getEl = function(id){
		return document.getElementById(id);
	};

	//탭의 갯수만큼 반복돌려서
	for(var i=0; i<tabList.length; i++){
		getEl(tabList[i].id).addEventListener("click", function(){
			setTimeout(function(){
                var resizeList =[];
                for(var j=0; j<gridList.length; j++){
                    AUIGrid.resize("#"+gridList[j].id);
                    resizeList.push("#"+gridList[j].id);
                }
                    gridResize(resizeList);
			},5);
		});
	}
}

/**
 * 화면 초기화
 * @param forms ['formId1', 'forId2']
 * @param grids ['grid1', 'grid2']
 * @param fileArea [filezone1, filezone2]
 * @returns
 */
function pageReset(forms, grids, fileArea, callback){

	var formId = "";
	var hidden;

	//초기화
	if(forms){
		for(var i=0; i<forms.length; i++){

			//form ID 생성
			formId = "#"+forms[i];
			//해당 form 하위 hidden 저장
			hidden = $(formId + " [type=hidden]");

            //formId 하위에 있는 selectbox2 객체 받음
            var select2 = $(formId + " .select2-hidden-accessible");

			//form 초기화
			$(formId)[0].reset();

            //selecbox2 초기화
            for(var j=0; j<select2.length; j++){
                $("#"+select2[j].id).val('').select2();
            }

			//hidden 초기화
			for(var j=0; j<hidden.length; j++){
				hidden[j].value = "";
			}
		}
	}

	//그리드 초기화
	if(grids){
		for(var i=0; i<grids.length; i++){
			AUIGrid.clearGridData(grids[i]);
		}
	}

	//파일 초기화
	if(fileArea){
		for(var i=0; i<fileArea.length; i++){
			fileArea[i].clear();
			fileArea[i].setFileIdx("");
		}
	}

	if(callback){
		callback();
	}
}

/**
 * 그리드 선택이나 더블클릭시 해당 form에 데이터 넣기
 * @param formId
 * @param selector
 * @param item
 * @param callback
 * @returns
 */
function gridDataSet(formId, selector, item, callback){
	formId = typeof formId != "string" ? undefined : formId[0] == "#" ? formId : "#"+formId;
	if(!item){
		return false;
	}
	item = (Array.isArray(item) == true) ? item[0] : item;
	var selectorArr = document.querySelector(formId).querySelectorAll(selector);

	for(var i = 0; i<selectorArr.length; i++){
		var type = selectorArr[i].type, id = selectorArr[i].id, name = selectorArr[i].name;
		if(!id) continue;
		if(item[id] != null ||item[id] != undefined || item[name] != null ||item[name] != undefined){
			if(type == "checkbox")
				document.getElementById(id).checked = (item[id] == "Y") ? true : false;
			else if(type == "radio")
				document.getElementById(id).checked = (item[name] == selectorArr[i].value) ? true : false;
			else{
				document.getElementById(id).value = item[id];
			}
		}else{
			if(type=="text" || type=="hidden" || type=="select-one" || type=="textarea"){
				getEl(id).value = '';
			}
		}
	}

	if(callback != undefined && typeof callback == "function"){
		callback();
	}
}

//숫자 콤마만
$(document).on("keyup", "input:text[numberOnly]", function() {
	$(this).number(true);
});


/**
 * 시작일시, 종료일시를 더하여 시간으로 환산
 * @param beginDt
 * @param endDt
 * @param sumTime
 * @returns
 */
function getFindTime(beginDt, endDt){

	beginDt = beginDt[0] == "#" ? beginDt : "#"+beginDt;
	endDt = endDt[0] == "#" ? endDt : "#"+endDt;

	//시작일시, 종료일시 두개에 값이 다 있으면 가동시간 계산하여 입력
	if($(beginDt).val() && $(endDt).val()){
		var startTime = $(beginDt).val().replace(/-/gi,""); // 시작일시 ('20090101 12:30:00')
	    var endTime  = $(endDt).val().replace(/-/gi,"");    // 종료일시 ('20091001 17:20:10')

	    // 시작일시
	    var startDate = new Date(parseInt(startTime.substring(0,4), 10),
	             parseInt(startTime.substring(4,6), 10)-1,
	             parseInt(startTime.substring(6,8), 10),
	             parseInt(startTime.substring(8,10), 10),
	             parseInt(startTime.substring(10,12), 10),
	             parseInt(startTime.substring(12,14), 10)
	    );

	    // 종료일시
	    var endDate   = new Date(parseInt(endTime.substring(0,4), 10),
	             parseInt(endTime.substring(4,6), 10)-1,
	             parseInt(endTime.substring(6,8), 10),
	             parseInt(endTime.substring(8,10), 10),
	             parseInt(endTime.substring(10,12), 10),
	             parseInt(endTime.substring(12,14), 10)
	    );

	    var timeGap = new Date(0, 0, 0, 0, 0, 0, endDate - startDate);

	    // 두 일자(startTime, endTime) 사이의 간격을 "일-시간-분"으로 표시한다.
  		var diffDay  = Math.floor((endDate.getTime() - startDate.getTime()) / (1000 * 60 * 60 * 24)); // 일수
  	    var diffHour = timeGap.getHours();       // 시간
  	    var diffMin  = timeGap.getMinutes();      // 분
  	    var diffSec  = timeGap.getSeconds();      // 초

  		var day = diffDay * 86400;  //일을 초로 변경
  		var hour = diffHour * 3600; //시간을 초로 변경
  		var min = diffMin * 60;     //분을 초로 변경
  		var sum = (day+hour+min+diffSec)/3600; //초까지 모두 더하여 시간구하기

  		return sum.toFixed(1);
	}
}


//팝업 오픈 공통
//window.open('팝업 주소', '팝업창 이름', '팝업창 설정');
function openPopup(url, name, prop){
	/*필요한 속성 Object타입으로 prop에 넘기기.
	    width : 팝업창 가로길이
		height : 팝업창 세로길이
		toolbar=no : 단축도구창(툴바) 표시안함
		menubar=no : 메뉴창(메뉴바) 표시안함
		location=no : 주소창 표시안함
		scrollbars=no : 스크롤바 표시안함
		status=no : 아래 상태바창 표시안함
		resizable=no : 창변형 하지않음
		fullscreen=no : 전체화면 하지않음
		channelmode=yes : F11 키 기능이랑 같음
		left=0 : 왼쪽에 창을 고정(ex. left=30 이런식으로 조절)
		top=0 : 위쪽에 창을 고정(ex. top=100 이런식으로 조절)
	  */
    var keys = Object.keys(prop);
    var option = "";
    for(var i = 0; i<keys.length; i++){
    	option += keys[i] + "=" + prop[keys[i]] + ", ";
    }

    option = option.substring(0,(option.length-1));
    return window.open(url, name, option);
}

function comboReset(obj, flag, msg) {
	obj = obj[0] == "#" ? obj.slice(1) : obj;
	obj = document.getElementById(obj);
    for(var i = obj.options.length - 1 ; i >= 0 ; i--){
    	obj.remove(i);
    }

	if(flag){
		var op = new Option();
		op.value = '';
		op.text = '선택';
		op.selected = true;
		obj.options.add(op);
	} else if(flag == false && msg != undefined){
		var op = new Option();
		op.value = '';
		op.text = msg;
		op.selected = true;
		obj.options.add(op);
	}
}

//setYear(오브젝트ID, 선택년도, 시작년도, 시작년도부터 몇개 더....)
//setYear('dteYear', null, 2018, 10); 옵션셋팅
//setYear('dteYear'); 기본셋팅
function setYear(cmbObjNm, iSelectYear, iStartYear, iEndYearNum) {
	var intNum;
	var currentYear;
	var thisDate = new Date();

	if (iEndYearNum == null || iEndYearNum == undefined)
		intNum = 10;
	else
		intNum = iEndYearNum;

	if (iSelectYear == null || iSelectYear == undefined)
		currentYear = thisDate.getFullYear();
	else
		currentYear = iSelectYear;

	var selName = document.getElementById(cmbObjNm);

	for (var i = iStartYear; i <= iStartYear + intNum; i++) {
	    var opt = document.createElement("option");
	    opt.value = i;
	    if (i == currentYear) {
	        opt.selected = "selected";
	    }
	    opt.appendChild(document.createTextNode(i));
	    selName.appendChild(opt);
	}
}

//PC or Mobile 체크
function mobileCheck(){
	var filter = "|win16|win32|win64|mac|macintel";
	if (navigator.platform){
		if(filter.indexOf(navigator.platform.toLowerCase()) > 0){
			return true;
		}else{
			return false;
		}
	}
}

function showLoadingbar() {
    $("#wrap-loading").show();
}

function hideLoadingbar() {
    $("#wrap-loading").hide();
}

/**
 *
 * @param grid 객췌
 * @param data 그냥 ajax결과물
 * @returns 그리드에 박아주고 사이즈 알아서늘여줍니다
 */
function gridStrechAutoSize(grid, data){
	AUIGrid.setGridData(grid, data);

	//메인랩 맨처음 시작하는부분. queryselector로 잡을까하다가 이게 더빨라서 이거로잡았음. 익스플로러 이상하게잡힐까봐
	var main = document.getElementsByClassName("subContent")[0];
	//값이 10 이상이 아니면 그냥 기본값으로 박아버리면됨. 사이즈 변동없음.
	if(data.length > 10){
		/**
		 * 자 설명.
		 * 한 row의 위아래 폭은 26px.
		 * 그리고 52 박은건 위에 헤더 폭이 52px인것임.
		 * 그래서 52 고정값 + 셀렉트해온 데이터의 길이 * 27을하면 그리드의 전체 사이즈가나옴.
		 * 그렇게 구해온것에 기본 그리드사이즈를 제외한 페이지의 길이가 904px - 300px = 604.
		 * 저 528px가 하단 그리드를 제외한 메인의 최소사이즈가 되는것이다.
		 * 그래서 604 + 만들어진 그리드 사이즈의 px를 더한것이 main의 총 사이즈가되고
		 * 헤더길이 + 데이터 수 * 27한값이 그리드의 사이즈가 된다.
		 */
		var size = (((data.length + 1) * 27) + 52); //그리드 전체 높이 사이즈
		main.style.height = size + 604 + "px";
		AUIGrid.resize(grid, null, size);
	} else{
		/**
		 * 자 설명.
		 * 그리드 기본사이즈 평균 300px.
		 * 메인의 총 사이즈는 904.**px. 하지만 난 정수를 좋아하므로 828로하였다.
		 * 그러면 메인 사이즈는 904px로 고정하고, 그리드 사이즈는 300px로 박는다. 이게 맨처음 초기값이다!
		 */
		var size = 300;
		main.style.height = "904px";
		AUIGrid.resize(grid, null, size);
	}
}

//두날짜 비교
function getCompareDate(startDate, endDate){
	var startArray = startDate.split('-');
    var endArray = endDate.split('-');

    //배열에 담겨있는 연,월,일을 사용해서 Date 객체 생성
    var start_date = new Date(startArray[0], startArray[1], startArray[2]);
    var end_date = new Date(endArray[0], endArray[1], endArray[2]);

    //날짜를 숫자형태의 날짜 정보로 변환하여 비교한다.
    if(start_date.getTime() > end_date.getTime()) {
        return false;
    }else{
    	return true;
    }
}

//정규식 비교 함수
/*
 * obj : 타켓
 * regStr : 정규식
 * */
function regTestFunc(obj, regStr){

	var objT = $("#"+obj.id)[0];
	var str = objT.value;

	if(!regStr.test(str)){
		objT.value = '';
	}
}

//deep copy
function clone(obj) {
  if (obj === null || typeof(obj) !== 'object')
  return obj;

  //constructor : 해당 객체와 똑같은 타입의 객체를 하나 더 생성하는 메소드
  var copy = obj.constructor();

  for (var attr in obj) {
	//hasOwnProperty : 해당 객체가 파라미터로 넘긴 프로퍼티를 가지고 있는지 확인하는 메소드
    if (obj.hasOwnProperty(attr)) {
      copy[attr] = clone(obj[attr]);
    }
  }

  return copy;
}

/*
 * 그리드 상태 저장
 * gridId : 페이지 그리드 ID
 *
 * 참고 : cmmnCodeM.jsp // setGrid();
 *
 *
 * */
function saveColumnLayout(gridId) {

    var pageName = getPageGridName(gridId);//페이지 그리드 명칭

	if ( typeof(Storage) != "undefined" ) {
		var columns = AUIGrid.getColumnLayout(gridId);

        for( var i=0; i<columns.length; i++ ){
            var column = columns[i];
            for( key in column ){
                if( typeof column[key] == "object" ){
                    for( inKey in column[key] ){
                        if ( typeof column[key][inKey] == "function"){
                            column[key][inKey] = column[key][inKey].toString();
                        }
                    }
                }
                if ( typeof column[key] == "function"){
                    column[key] = column[key].toString();
                }
            }
        }

		localStorage.setItem(pageName, JSON.stringify(columns)); //해당 그리드에 로컬스토리지 추가
		location.reload();

	} else {
		warn("localStorage 를 지원하지 않는 브라우저입니다.");
		return;
	}
};


//그리드 상태 리셋
function resetColumnLayout(gridId) {

	//페이지그리드 명칭
    var pageName = getPageGridName(gridId);

	if ( typeof(Storage) != "undefined" ) {
			localStorage.removeItem(pageName);  //해당 로컬 스토리지 삭제
			location.reload();
	} else {
		warn("localStorage 를 지원하지 않는 브라우저입니다.");
		return;
	}
};

//로컬스토리지 저장할 명칭세팅
function getPageGridName(gridId){

    var strPageName = window.location.href.split("/");
    var curGrid  = gridId.replace('#','');

    var pageName = strPageName[strPageName.length-1].split("?")[0];
        pageName = pageName + "_auigridLayout_" + curGrid;

    return pageName;
}


// localStorage 값
function getLocalStorageValue(key) {

    if( !!!localStorage.getItem(key) ){
        return;
    }

	if(typeof(Storage) != "undefined") { // Check browser support

        var columns = JSON.parse(localStorage.getItem(key));
        for( var i=0; i<columns.length; i++ ){
            var column = columns[i];
            for( key in column ){
                var value = column[key];
                if( typeof column[key] == "object" ){
                    for( inKey in column[key] ){
                        if ( column[key][inKey].toString().indexOf("function") == 0 ){
                            column[key][inKey] = new Function('return ' + column[key][inKey] )();
                        }
                    }
                }
                if ( column[key].toString().indexOf("function") == 0 ){
                    column[key] = new Function('return ' + value )();
                }
            }
        }

		return columns;
	} else {
		warn("localStorage 를 지원하지 않는 브라우저입니다.");
	}
};

/**
 * =======================================================================
 * jquery promise를 return하는 ajax
 * 후성 CustomException class를 사용하여 Exception을 핸들링 하는경우 사용.
 * 에러 발생시 화면에 error seqno, 개발자 customMessage 출력.
 * =======================================================================
 *
 * @author shs
 * @param {Object} options
 *
 * options param detail.
 *      @param {String}     url             -> Request url
 *      @param {Object}     data            -> 전송할 data
 *      @param {Boolean}    async           -> 동기 or 비동기 통신
 *      @param {Boolean}    showLoading     -> 로딩 spinner 쓸지말지 ?
 *      @param {Array}      elementIds      -> 중복 클릭을 방지하기 위한 버튼 id들
 *      @param {Array}      elementNames    -> 중복 클릭을 방지하기 위한 버튼 name들
 */
 function customAjax(options){
    var url = options.url || "";
    var data = options.data || {};
    var async = options.async || true //async 기본값 true
    var showLoading = ( options.showLoading == undefined || options.showLoading == null ) ? true : options.showLoading; //showLoading 기본값 true
    var elementIds = options.elementIds || [];
    var elementNames = options.elementNames || [];
    var successFunc = options.successFunc || null;
    var errorFunc = options.errorFunc || null;
    var completeFunc = options.completeFunc || null;

    return $.ajax({
        url : url,
        method: "post",
        type: "json",
        async: async,
        contentType: "application/json; charset=utf-8",
        data : JSON.stringify(data),
        beforeSend : function(xmlHttpRequest){

            designer(true);

            xmlHttpRequest.setRequestHeader("AJAX", async); // ajax 호출을  header에 기록

        }, success : function(data,status,request){

    		if(typeof successFunc === "function"){successFunc(data, status, request);}
            designer(false);

        }, error : function(request,status,error) {

            designer(false);

            if(request.status == 404) {
                err("status : " + request.status + ". 유효하지 않은 주소 입니다.");
                return false;
            }

            if(request.status == 401) {
                warn("다시 로그인을 해야 합니다.");
                document.location.href="/logout.lims";
                return false;
            } else {
                if(request.responseText != undefined){
                    var resTxt = JSON.parse(request.responseText);
                    if( !!resTxt.error ){
                        var errorMsg = (!!resTxt.error.dvlprDc) ? resTxt.error.dvlprDc : "[ system message가 제공되지 않았습니다. 관리자에게 문의해 주세여요. ]";
                        var message = (resTxt.error.excpLogSeqno)?
                            "system code : " + resTxt.error.excpLogSeqno + "<br/>"
                            + "system message : " + errorMsg + "<br/>" :
                            "system message : " + errorMsg + "<br/>"
                        warn(message);
                    }
                }
            }

            if(typeof errorFunc === "function"){errorFunc(request, status, error);}
        }
        ,complete : function(){
            if(typeof completeFunc === "function"){completeFunc();}
            designer(false);
        }
    });

    /**
     * ajax designer.
     */
    function designer(bool) {

        // mouse cursor wait !
        (bool) ? $('html').css("cursor", "wait") : $('html').css("cursor", "auto");

        buttonDisable(elementIds,elementNames,bool);

        // loading Spinner
        if(showLoading){
            (bool) ? $("#wrap-loading").show() : $("#wrap-loading").hide();
        }
    }

    //button disabled true or false
    function buttonDisable(elementIds,elementNames,bool){

        if(elementIds.length > 0){
            for(var i=0; i<elementIds.length; i++){
                var el = elementIds[i];
                document.getElementById(el).disabled = bool;
            }
        }

        if(elementNames.length > 0){
            for(var i=0; i<elementNames.length; i++){
                var name = elementNames[i];
                var elements = document.getElementsByName(name);

                for(var k=0; k<elements.length; k++){
                    var el = elements[k];
                        el.disabled = bool;
                }
            }
        }
    }
}

/**
 * ===============================================
 * 필수값,유효성 체크를 원하는 HTML element에
 * required 속성, validator 속성 추가하고 사용해야함.
 * input 속성정의
 *  1. required : 필수값 체크 필드
 *  2. data-validator : 유효성 체크 필드
 *      2-1. tel : 전화번호 유효성 체크
 *      2-2. email : 이메일 유효성 체크
 *      2-3. accountNumber : 계좌번호 유효성 체크
 * ===============================================
 * @author  shs
 * @param   {String} formId
 * @return  {Boolean}
 * @ex      if(!saveValidation(prdlstFrm)) return false;
 */
 function saveValidation(formId, bool){

    var saveFlag = true;

	$('#' + formId).find('input, textarea, select').each(function(){
        var element =  $(this);
        var value = this.value;

        //bool이 true이면 ignoreElement 클래스를 가진 태그까지 밸리데이션 체크함.
        if(!!bool){

            var ignoreElement = document.getElementsByClassName('ignoreElement');
            if(Array.prototype.filter.call(ignoreElement, function(testElement) {
                return testElement.id === element.prop("id");
            }).length > 0){
                return true;
            };

        }

        //validator 속성 get IE 11이하 version 때문에 getAttribute() 사용.
        var validator = this.getAttribute('data-validator');
        var required = this.required;

        //체크박스 required시
        if(element.prop("type") == "checkbox" && required){

            var chkedCnt = 0;
            var elByname = $("input[name=" + element.prop("name") + "]");

            //체크박스 체크된게 있는지 확인
            elByname.each(function(){
                var chkBoxEl = $(this);
                if(chkBoxEl.prop("checked")){
                    chkedCnt++;
                }
            });

            if( chkedCnt == 0 ){
                warn(element.closest("td").prev()[0].innerText.replace("*","") + "(은)는 필수 입력 항목입니다.");
                element.focus();
                saveFlag = false;
                return false;
            }
        }

        /**
         * 필수값 체크
         * required 속성을 가지고있는데 값이 없는 경우 warning
         */
		if(value == "" && required){
			warn(element.closest("td").prev()[0].innerText.replace("*","") + "(은)는 필수 입력 항목입니다.");
			element.focus();
			saveFlag = false;
			return false;
        }

        //전화번호 체크
        if(validator == "tel" && !!value){
            var regExp = /^\d{2,3}-\d{3,4}-\d{4}$/;
            if(!regExp.test(value)){
                warn(element.closest("td").prev()[0].innerText.replace("*","") + "(은)는 잘못된 형식의 전화번호 입니다.");
                element.focus();
                saveFlag = false;
                return false;
            }
        }

        //이메일 체크
        if(validator == "email" && !!value){
            var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
            if(!regExp.test(value)){
                warn(element.closest("td").prev()[0].innerText.replace("*","") + "(은)는 잘못된 형식의 이메일 입니다.");
                element.focus();
                saveFlag = false;
                return false;
            }
        }

        //계좌번호 체크
        if(validator == "accountNumber" && !!value){
            var regExp = /^[0-9][0-9\-]*[0-9]$/;
            if(!regExp.test(value)){
                warn(element.closest("td").prev()[0].innerText.replace("*","") + "(은)는 잘못된 계좌번호 입니다.");
                element.focus();
                saveFlag = false;
                return false;
            }
        }
    });
    return saveFlag;
}

/**
 *
 * grid require check function.
 * 필수값체크에 걸리면 해당 cell을 선택, warning msg 출력.
 *
 * @author shs
 * @param {*} options {
 *      {Array}         requireColumns  : 필수값을 체크할 컬럼들
 *      {String}        gridId          : 그리드 id
 *      {Array[Object]} list            : 필수값을 체크할 그리드 데이터
 *      {Boolean}       zeroCheck       : 0도 빈값으로 체크할껀지 ?
 *      {String}        msg             : warning msg
 * }
 *
 * @see isEmpty()
 * @returns boolean
 */
function gridRequire(options){

    var requireColumns = options.requireColumns;
    var gridId = options.gridId;
    var list = options.list || [];
    var zeroCheck = options.zeroCheck || false;
    var msg = options.msg || lang.C000000263; //값을 입력 또는 선택해 주세요.

    var bool = true;
    var rowIdField = AUIGrid.getProp(gridId, "rowIdField");

    if( !!!list){
        warn( gridId + "--> target grid div is not found !");
        return false;
    }

    for( var i=0; i<list.length; i++ ){

        var obj = list[i];
        var rowIndex = AUIGrid.getRowIndexesByValue(gridId, rowIdField, obj[rowIdField])[0]; //선택 표시해주기 위한 row index
        
        var columns = AUIGrid.getColumnLayout(gridId); //grid columns
        for (var k = 0; k < columns.length; k++) {
            var colObj = columns[k];
            var col = colObj.dataField; //col dataField
            var val = obj[col]; // column value is nullable. column의 value는 null or undefiend일 가능성이 있음.

            //현재 검사중인 컬럼이 requireColumns에 포함되있는 컬럼인지.
            var isRequire = isArrayIncludes(requireColumns, col);
            var isEmpty_ = isEmpty(val);
            //값이 없으면서 require column이면
            if( isRequire && isEmpty_ ){

                var colIndex = colObj.columnIndex; // col index

                //validation 체크당한 행 선택 표시
                AUIGrid.setSelectionBlock(gridId,rowIndex,rowIndex,colIndex,colIndex);

                warn(msg); //기본값은 -> 값을 입력 또는 선택해 주세요.

                return false;
            }

            /**
             * 유효성 체크에 모두 통과, string type에다가 유효한 value이면
             * 의도치않은 빈칸 제거
             */
            if( typeof val == "string" && !isEmpty_ ){
                obj[col] = val.trim();
            }
        }
    }

    return bool;

    /**
     * zeroCheck가 true인 경우 0도 빈값으로 판단하여 boolean return함.
     * zeroCheck가 false인 경우 0은 빈값으로 체크하지 않는다.
     */
    function isEmpty(val){
        return (zeroCheck) ? ( !!!val || val === "0" ) : ( val === undefined || val === null || val === "" );
    }
}

/**
 * =========================================
 * 그리드 cellClick시 상세정보 Set해줌.
 * 그리드 column과 동일한 element id 를 검색해서
 * 값을 set해준다.
 *
 * comma class를 가진 field는 comma 붙여줌
 * =========================================
 * @author shs
 * @param {Object}  options {
 *      {Object} item           : bind할 item
 *      {Array}  targetFormArr  : bind할 form id
 *      {Array}  ignoreFormArr  :   검색from VO 객체들이 AUIGrid에 존재하기때문에
 *                                  검색from 객체들은 무시하고 바인딩하기위하여 parameter로 받는다.
 *      {String} idGubun        : idGubun값을 붙여서 bind함. 구분을 위한 parameter임.
 *      {function} successFunc  : 모든 작업이 끝난후 마지막에 실행될 callback fucntion
 * }
 */
function detailAutoSet(options){

    var item = options.item || {};
    var targetFormArr = options.targetFormArr || [];
    var ignoreFormArr = options.ignoreFormArr || [];
    var ignoreElementArr = options.ignoreElementArr || [];
    var idGubun = options.idGubun || "";
    var successFunc = options.successFunc || null;

    //ignoreFormArr이 있으면 해당form 객체 element들 바인딩안함
    if( ignoreFormArr.length > 0 ){

        for(var i=0; i<ignoreFormArr.length; i++){
            var ignoreForm = $("#" + ignoreFormArr[i]);
            ignoreForm.find('input,select').each(function(){
                var schEl = $(this).attr('name');

                /**
                 * IE delete연산자 이슈로 인한 code변경
                 * delete item[schEl]; -> item[schEl] = undefined; JSON.parse(JSON.stringify(item));
                 */
                item[schEl] = undefined;
            });
        }

        //ignoreForm의 name과 같은 key들을 없앰
        item = JSON.parse(JSON.stringify(item));
    }

    //targetFormArr Form중에 바인딩하고 싶지 않은 Element가 있을 경우 사용
    if(ignoreElementArr.length > 0){
        for (var i = 0; i < ignoreElementArr.length; i++){
            item[ignoreElementArr[i]] = undefined;
        }

        item = JSON.parse(JSON.stringify(item));
    }

    //targetForm 단위로 데이터 bind
    for(var i=0; i<targetFormArr.length; i++){

        var targetForm = document.querySelector('#' + targetFormArr[i]);

        //key값이 맞는 element를 찾아 value set
        for(var key in item){

            // id or name으로 존재하지않으면 건너뜀
            if(!!!document.getElementById(key + idGubun) && document.getElementsByName(key).length === 0 ){
                continue;
            }

            //document객체에서 element 검색
            var validTargetEl = targetForm.querySelector('#' + key + idGubun);
            var validTargetName = targetForm.querySelector('[name='+ key +']'); // (name값은 구분 안씀)

            //name or id 둘중하나 있어야됨
            if( !!validTargetEl || !!validTargetName ){

                // targetForm 하위 Element
                var element = (!!validTargetEl) ? validTargetEl : validTargetName;
                
                // checkbox와 radio는 value를 세팅하지 않는다.
                if(element.type !== "radio" && element.type !== "checkbox"){
                    element.value = (item[key] !== null && item[key] !== undefined) ? item[key] : '';

                    //select2 plugin 이용하는 selectbox의 경우 값 set 이후에 trigger change이벤트 발생시켜야 값이 적용됨.
                    if( element.classList.contains("select2-hidden-accessible") ){
                        $(element).change();
                    }
                }

                // css comma적용되어있는 Element comma처리
                if(element.classList.contains("comma") === true){

                    //Intl API 한국식 숫자표기 -> 소수점포함 16자리숫자에 comma찍어줌 maximumFractionDigits : 8 -> 소수점은 8자리까지 표기
                    var intl = new Intl.NumberFormat('ko-KR',{maximumFractionDigits : 10});
                    element.value = ( item[key] === null || item[key] === undefined ) ? 0 : intl.format(item[key]);
                }

                //input radio 버튼 check 처리
                var radios = targetForm.querySelectorAll('input[type=radio][name='+ key +']');
                if(radios.length > 0){

                    for (var j = 0; j < radios.length; j++) {
                        var radio = radios[j];
                        
                        //해당 radio의 값과 일치하면 체크하도록
                        if(radio.value === item[key]){
                            radio.checked = true;
                        }
                    }
                }

                //체크박스 버튼 check 처리
                var checkboxes = targetForm.querySelectorAll('input[type=checkbox][name='+ key +']');
                if(checkboxes.length > 0){

                    for (var j = 0; j < checkboxes.length; j++) {
                        var checkbox = checkboxes[j];
                        
                        //해당 checkbox의 값과 일치하면 체크
                        if(checkbox.value === item[key]){
                            checkbox.checked = true;
                        }
                    }
                }
            }
        }
    }

    if(!!successFunc && typeof successFunc === "function"){
    	successFunc();
    }
}

/**
 * ==========================================================
 * .comma class사용시 해당 field에 comma붙여줌
 * 문자는 입력불가 숫자만 입력가능.
 *
 * .comma class 붙어있는 field는 detailAutoSet() function으로
 * data bind시에 comma가 붙어서 data setting됨
 * ==========================================================
 * @author shs
 * @see detailAutoSet()
 */
function putComma(){
    //comma class 필드들 comma 붙여줌
    document.querySelector('#sub_wrap').addEventListener("input", function(e){
        if( e.target.classList.contains('comma')){
            unComma([e.target.id]);
            var intl = new Intl.NumberFormat();
            e.target.value = intl.format(e.target.value)
        }
    });
}

/**
 * =====================================================
 * 공통 날짜 유효성 체크
 * dateChk, dateTimeChk css class속성에 맞는 정규식으로 체크
 * =====================================================
 * @author shs
 * @ex     <input type="text" name="validBeginDte" id="validBeginDte" class="dateChk">
 */
function dateValidChk(e){

    var dateChk = e.target.classList.contains('dateChk');
    var dateTimeChk = e.target.classList.contains('dateTimeChk');

    // YYYY-MM-DD or YYYYMMDD check
    if(dateChk){
        var value = e.target.value;

        var pattern1 = /^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/; // YYYY-MM-DD
        var pattern2 = /^\d{4}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[0-1])$/; // YYYYMMDD

        //정규식 검사
        if(!!value){
            if(pattern1.test(value)) {
                // value = YYYY-MM-DD
            } else if(pattern2.test(value)) {
                // value = YYYYMMDD
                e.target.value = value.slice(0, 4) + '-' + value.slice(4, 6) + '-' + value.slice(6);
            } else {
                warn("날짜 형식이 맞지 않습니다. [" + getFormatDate() + ", 또는 " + getFormatDate().replaceAll("-","") + "] 형식으로 입력해 주세요.");
                e.target.value = "";
                e.target.focus();
                return false;
            }
        }
    }
    
    // YYYY-MM-DD HH:mm:SS or YYYYMMDDHHmmSS check
    if (dateTimeChk) {
        var value = e.target.value;

        var pattern1 =  /^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1]) (0[0-9]|1[0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$/; //YYYY-MM-DD HH:mm:SS
        var pattern2 = /^\d{4}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[0-1])(0[0-9]|1[0-9]|2[0-3])([0-5][0-9])([0-5][0-9])$/; // YYYYMMDDHHmmSS

        //정규식 검사
        if(!!value){
            if(pattern1.test(value)) {
                // value = YYYY-MM-DD HH:mm:SS
            } else if(pattern2.test(value)) {
                // value = YYYYMMDDHHmmSS
                e.target.value = value.slice(0, 4) + '-' + value.slice(4, 6) + '-' + value.slice(6,8)+' '+value.slice(8,10)+":"+value.slice(10,12)+":"+value.slice(12);
            } else {
                warn("날짜 형식이 맞지 않습니다. [" + getFormatDateTime() + ", 또는 " + getFormatDateTime().replaceAll("-","",":") + "] 형식으로 입력해 주세요.");
                e.target.value = "";
                e.target.focus();
                return false;
            }
        }
    }
}

/**
 * .numChk : 숫자만 입력체크
 * .numChkPoint : 소수점을 포함한 숫자 입력체크
 * @author shs
 */
function numValidation(){

    document.querySelector('#sub_wrap').addEventListener("input", function(e){

        var activeNumChk = e.target.classList.contains('numChk');
        var activeNumChkPoint = e.target.classList.contains('numChkPoint');

        if( activeNumChk || activeNumChkPoint ){

            var val = e.target.value;

            //숫자 체크, 소수점 체크
            if(activeNumChk){
                e.target.value = val.replace(/[^\d]+/g, '');
                return false;
            }
    
            var testStr = Number(val);
            var regExp = (activeNumChk) ? /^[0-9]+$/ : /^[0-9]+(?:[.][0-9]+)?$/;
            if( !regExp.test(testStr) && activeNumChkPoint ){
                warn('숫자와 소수점만 입력해 주세요!');
    
                e.target.value = val.substring(0, val.length - 1);
                e.target.focus();
                return false;
            }
        }
    });
}

/**
 * HTML maxlength 속성을 이용해 byte체크.
 * event 대상 - maxlength 속성이 정해져 있는 <input>, <textarea>
 * @author shs
 */
function byteLimiter(){
    document.querySelector('#sub_wrap').addEventListener("input", function(e){
        if( (e.target.nodeName === 'INPUT' || e.target.nodeName === 'TEXTAREA') && e.target.maxLength > 0){
            fnChkByte(e.target, e.target.maxLength);
        }
    });
}

/**
 * [저장 쿼리 전 사용]
 * 금액관련 필드들에 comma가 붙어있다면
 * comma 지워줌.
 * @author shs
 * @param {Array} ids
 */
function unComma(ids) {
    for(var i=0; i<ids.length; i++){
        var el = $("#" + ids[i]);
            el.val(el.val().replace(/[^\d]+/g, ''));
    }
}

/**
 * comma를 지운 데이터 return
 * @author shs
 * @param {Array} ids
 * @return {Object} returnObj {
 *                      key     : 해당 element의 id
 *                      ,value  : 해당 element의 value
 *                  }
 */
function getUnCommaVal(ids){

    var returnObj = {};

    for(var i=0; i<ids.length; i++){
        var el = $("#" + ids[i]);
        var val = el.val();
        returnObj[el.prop("id")] = Number(val.replace(/[^\d]+/g, ''));
    }

    return returnObj;
}


/**
 * 배열내 같은 key가 존재할 경우 제거하고
 * unique한 배열 return함
 * @param {Array[Object]} array 중복을 제거할 배열 Array Object 배열
 * @param {String} key 중복을 제거할 때 기준이 될 key
 * 
 * @author google
 * @modify shs
 * @see arrayIncludes()
 */
function getUniqueObjArray(array, key) {
    var tempArray = [];
    var resultArray = [];
    for(var i = 0; i < array.length; i++) {

        var obj = array[i];
        if(isArrayIncludes(tempArray,obj[key])) {
            continue;
        } else {
            resultArray.push(obj);
            tempArray.push(obj[key]);
        }
    }
    return resultArray;
}

/**
 * 배열에 찾으려고 하는 값이 있는지 없는지를
 * 확인하여 값존재여부 return
 * @param   {Array} array
 * @param   {String} findValue
 * @return  {Boolean} bool
 * 
 * @author shs
 * @see getUniqueObjArray()
 */
function isArrayIncludes(array,findValue){

    var bool = false;
    var len = array.length;

    for(var i=0; i<len; i++){
        if( array[i] == findValue ){
            bool = true;
            break;
        }
    }
    return bool;
}

/**
 *
 * List[{Ojbect}] 형식의 list에서 찾으려고 하는 값이 있는지 없는지를
 * 확인하여 값존재여부 return
 * @param { List[{Ojbect}] } array
 * @param {String} findValue
 * @return {Boolean} bool
 * 
 * @author shs
 */
function isObjArrIncludes(array,findValue){

    var bool = false;
    var len = array.length;

    for(var i=0; i<len; i++){
        var obj = array[i];
        for(key in obj){
            if( obj[key] == findValue ){
                bool = true;
                break;
            }
        }
    }
    return bool;
}

/**
 * key를 기준으로 originArr에서 중복되는 index arr에서 제거 후 return.
 *
 * @author shs
 * 
 * @param {Object} options { ↓ option설명
 *     {Array[Object]}   targetArr  원본 array
 *     {Array[Object]}   testArr    중복인지 확인하고싶은 array
 *     {String}          key        key값 기준으로 중복 제거할 것.
 *     {String}          type       AUIGrid의 AUIGrid.getSelectedItems(gridId); method를 사용하여 얻은 array의 경우 "selectedItems"로
 * }
 * 
 * @retrun {Object} {
 *      {Arrya[Object]} resultArray     : 중복 제거된 array
 *      {Boolean}       isDuplicated    : 중복된 index가 발견 됬는지 안됬는지 여부. ture : 중복. 중복일 경우 후처리를 위해 return
 * }
 * @see TrendStdrM.jsp
 */
function arrayDropDuplicates(options){

    var targetArr = options.targetArr;
    var testArr = options.testArr;
    var key = options.key;
    var type = options.type || "default";

    var isDuplicated = false;
    for(var i=0; i<targetArr.length; i++){
        for(var j=0; j<testArr.length; j++){
            //arr에서 중복된 index제거
            if( targetArr[i][key] == ( (type == "selectedItems") ? testArr[j]["item"][key] : testArr[j][key] ) ){
                testArr.splice(j,1);
                isDuplicated = true;
            }
        }
    }

    return {
        resultArray : testArr
        ,isDuplicated : isDuplicated
    };
}

/**
 * ========================================================
 * form method : POST
 *
 * window.open()하고 난뒤
 * server에서 response를 form target으로.
 * ========================================================
 *
 *
 * @param {String} url           url
 * @param {Object} param         parameter Object형식으로 보내줘야 formData를
 *                               paramter갯수만큼 input생성함
 *
 * @param {String} windowName    windowName
 * @param {Number,String} width  window 너비
 * @param {Number,String} height window 높이
 * 
 * @author shs
 */
 function windowPostOpen(url,param,windowName,width,height){

    var formName = "windowOpen_" + windowName;
    var target = windowName;
    var menuSeqno=btoa(param.menuSeqno);
    var menuUrl=btoa(param.menuUrl);
    // 이곳에서 팝창의 스타일을 지정한다.
//    var form = document.createElement("form");
//        form.name = formName;
//        form.target = target;
//        form.method = "POST";
//        form.action = url+"?menuSeqno="+menuSeqno+"&menuUrl="+menuUrl;

//    for( key in param){
//        var input = document.createElement("input");
//            input["type"] = "hidden";
//            input["name"] = key;
//            input["value"] = param[key];
//
//        form.appendChild(input);	
//    }
//    document.body.appendChild(form);

    var left = window.screenLeft + 20;
    var windowOpen = window.open(url+"?menuSeqno="+menuSeqno+"&menuUrl="+menuUrl,target, "width=" + width + ", height=" + height +"toolbar=no, menubar=no, scrollbars=yes, resizable=yes, top=20, left=" + left);


}

 function encryptionString(stringVal,decryption){
	    var testval = "";
	    if(decryption){
	    for(var i=0; i<stringVal.length;i++){
	    	testval+=String.fromCharCode(stringVal[i].charCodeAt(0)+(new Date).getDate());
	    }
	    }else{
	    	for(var i=0; i<stringVal.length;i++){
		    	testval+=String.fromCharCode(stringVal[i].charCodeAt(0)-(new Date).getDate());
		    }
	    }
	    return testval;
 }
 
/**
 * 클립보드로 복사해줌
 * @param {String} copyVal
 * @author shs
 */
 function copyClipBoard(copyVal){

    var emptyEl = document.createElement("textarea");
    document.body.appendChild(emptyEl);

    emptyEl.value = copyVal;
    emptyEl.select();

    document.execCommand('copy');
    document.body.removeChild(emptyEl);
}


/**
 * form 하위 요소 return
 * parameter에 따라 disabled 되더라도 form 하위 element를 얻을 수 있다.
 *  
 * @param {Boolean} disableOption disabled 여부. 
 *                               true -> disabled도 get. false -> diabled뺴고 get
 * @returns {Object} object
 * @author shs
 */
HTMLFormElement.prototype.toObject = function( disableOption ){

    var _disableOption = ( disableOption !== undefined ) ? disableOption : false; //기본값 false
    var obj = {};
    var elements = this.elements;
    
    for( var j=0; j<elements.length; j++ ){

        var element = elements[j];
        var elName = element.name;
        if(!!!elName){
            continue;
        }

        if( element.nodeName === 'INPUT' && element.type === 'radio' && isValid(element) ){
            obj[elName] = Array.prototype
                .filter.call(this.querySelectorAll('input[name=' + elName + ']'), function(radio){
                    return radio.checked;
                })
                .map(function (radio) {
                    return radio.value;
                }).toString();
        } else if( element.nodeName === 'INPUT' && element.type === 'checkbox' && isValid(element) ){

            obj[elName] = Array.prototype
                .filter.call(this.querySelectorAll('input[name=' + elName + ']'), function(checkbox){
                    return checkbox.checked;
                })
                .map(function (checkbox) {
                    return checkbox.value;
                }).toString();

        } else if( isValid(element) ){
            obj[elName] = element.value;
        }
    }

    return obj;

    // disable opiotion에 따른 조건문 return
    function isValid(element){
        return _disableOption ? (element.name !== undefined) : (element.name !== undefined) && !element.disabled
    }
}

/*
* 결과값의 소수점 자리수에 따라 Random 값 계산
*
* @author syk
* @param String value  결과값
* @param String markCphr  소수점자리수
* @return String
*
*/
function randomCalcDigits(value){
    //Math.abs((Math.random()-0.5))
    if(value){
        var random = Math.abs(Math.random()-0.5).toString();
        var valArr = value.toString().split(".");
        var digit = 0;

        //소수점있으면
        if(valArr.length > 1){
        //소수점 자리수 구하기
        digit = valArr[1].length;

        random = random / Math.pow(10, digit);
        }
        console.log("eval : " , eval(value+"+"+random));
        return eval(value+"+"+random);
    }else{
        return value;
    }
}

 /**
 * ==========================================================================
 * select2 library Reference url : https://select2.org/
 *
 * ajax 데이터를 이용하여 select box 생성한다.
 * select2 plugin을 이용하여 검색가능한 selectbox를 rendering한다.
 * select2Props paremeter를 이용하여 select2 생성시 옵션을 custom할 수 있다.
 *
 * 참고.
 * 1. 키보드 tab 입력시 focus가 자동으로 되지않아 이벤트 부여 all.js 참고
 * 2. space bar, enter key 입력시 이슈 발생하여 keypress 이벤트 방지.
 * 3. selectbox에 javascript value or jquery val() 함수 이용할 때
 *      값이 바로 bind되지않음. $('el').trigger('change') 이벤트를 발생시켜줘야 bind됨.
 *
 * 4. select2 이용시 width option.
 *      - style : html element의 style태그 width 값으로 설정
 *      - 값 바로전달 : 옵션이 아닌 값을 전달 ex) 80%.
 *      - 나머지 width옵션들은 select2 reference url참고
 * ==========================================================================
 *
 * @author shs
 * @param {Object} paramObj {
 *      {String}    ajaxUrl             ajax request url
 *      {String}    ajaxParam           ajax parameter
 *      {String}    elementId           elementId
 *      {String}    defaultVal          default 세팅값
 *      {Object}    select2Props        select2 옵션 object
 *      {String}    customTopMsg        커스텀 메세지
 *      {Boolean}   topMsg              select option 태그 최상위에 "선택" 값 여부
 *      {Boolean}   disabled            disabled 여부
 *      {Boolean}   asyncType           comboAjaxJsonParam() 실행시 async 타입임.
 *      {function}  callback            callback fucntion
 * }
 */
function ajaxSelect2Box(paramObj) {

    var ajaxUrl = paramObj.ajaxUrl;
    var ajaxParam = (!!paramObj.ajaxParam) ? paramObj.ajaxParam : null;
    var elementId = paramObj.elementId;
    var topMsg = (!!paramObj.topMsg) ? paramObj.topMsg : true; //기본값 true
    var customTopMsg = paramObj.customTopMsg;
    var defaultVal = ( !!paramObj.defaultVal ) ? paramObj.defaultVal : ""; //기본값 ""
    var disabled = paramObj.disabled;
    var select2Props = paramObj.select2Props;
    //asyncType 기본값 true
    var asyncType = ( paramObj.asyncType == undefined || paramObj.asyncType == null ) ? true : paramObj.asyncType;

    //select2 default option object
    var props = {
        width : 'style'
        ,language : {
            noResults : function(){
                return "결과값이 없습니다.";
            }
        }
    }

    //자유롭게 작성한 select2 props 추가 !
    if(!!select2Props){
        for(key in select2Props){
            props[key] = select2Props[key];
        }
    }

    return customAjax({
        url : ajaxUrl
        ,data : ajaxParam
        ,async :  asyncType
        ,showLoading : false
        ,"successFunc" : function(data){
            $("#" + elementId).empty();

            //select option 태그 최상위에 "선택" 값 여부 있으면서 커스텀 msg 없으면 선택 박음
            if(!!topMsg && !!!customTopMsg){
                $("#" + elementId).append("<option value=''>선택</option>");

            //둘다 true이면 customTopMsg박음
            }else if( !!topMsg && !!customTopMsg ){
                $("#" + elementId).append("<option value=''>"+ customTopMsg +"</option>");
            }

            //data setting
            $(data).each(function(index, entry) {
                $("#" + elementId).append("<option value='" + entry["value"] + "'>" + entry["key"] + "</option>");
            });

            //기본 선택값
            if(!!defaultVal){
                $('#'+elementId).val(defaultVal);
            }

            //disabled 옵션
            if(disabled != undefined){
                $('#'+elementId + ' option').not(':selected').prop('disabled', true);
            }

            //select2 rendering, 옵션 적용
            $("#" + elementId).select2(props);

            /**
             * select2 이용시 enterKey or space
             * 키에 대한 이슈가 발생하여 keypress 방지함
             */
            $("#" + elementId).keypress(function(){
                return false;
            });

            //callback 실행
            if(paramObj.callback != undefined && paramObj.callback != null){
                paramObj.callback(defaultVal);
            }
         
//            var width = $('.select2-container').width()+"px"
//            $('.select2-container')[0].style.maxWidth=width;
//	 	      $("#"+elementId).select2({ width: width });
        }
    });
}	

/**
 * toastr js
 *
 * window.alert 재정의, 새로 정의한 function들 입니다.
 *
 * @param {*} msg
 * @param {Object} devOptions toastr js options
 *
 * @author shs
 * @see https://github.com/CodeSeven/toastr
 * @see https://codeseven.github.io/toastr/demo.html
 */
//alert 재정의
window.alert = function(msg, devOptions){

    var options = {
        progressBar: true
        , positionClass: "toast-center-center"
        , timeOut: "2000"
        , extendedTimeOut: "2000"
    }

    //devOptions 추가 !
    if(!!devOptions){
        for(key in devOptions){
            props[key] = devOptions[key];
        }
    }

    toastr.info(msg ,'FOOSUNG', options).attr('style', 'width: 500px !important');
}

//error toastr
window.err = function(msg, devOptions){

    var options = {
        progressBar: true
        , positionClass: "toast-center-center"
        , timeOut: "2000"
        , extendedTimeOut: "2000"
    }

    //devOptions 추가 !
    if(!!devOptions){
        for(key in devOptions){
            props[key] = devOptions[key];
        }
    }

    toastr.error(msg ,'FOOSUNG', options).attr('style', 'width: 500px !important');
}

//info toastr
window.success = function(msg, devOptions){

    var options = {
        progressBar: true
        , positionClass: "toast-center-center"
        , timeOut: "2000"
        , extendedTimeOut: "2000"
    }

    //devOptions 추가 !
    if(!!devOptions){
        for(key in devOptions){
            props[key] = devOptions[key];
        }
    }

    toastr.success(msg ,'FOOSUNG', options).attr('style', 'width: 500px !important');
}

//info toastr
window.warn = function(msg, devOptions){

    var options = {
        progressBar: true
        , positionClass: "toast-center-center"
        , timeOut: "2000"
        , extendedTimeOut: "2000"
    }

    //devOptions 추가 !
    if(!!devOptions){
        for(key in devOptions){
            props[key] = devOptions[key];
        }
    }

    toastr.warning(msg ,'FOOSUNG', options).attr('style', 'width: 500px !important');
}

/*
 * currDte 메인 계산할 날짜
 * crrCycle 주기
 * crrCycleCode 주기코드
 * colId 계산 후 적용할 Id
 * SY14000001	년
 * SY14000002	반기
 * SY14000003	분기
 * SY14000004	월
 * SY14000005	일
 *
 * 참고 EqpmnInspcCrrct.jsp
 * kkh
 */
function nextCrrctDteEvent(crrDte, crrCycle, crrCycleCode, colId){

	var date = new Date(crrDte);
	crrCycle = parseInt(crrCycle);

	if(crrDte){

		if(crrCycleCode == "SY14000001"){
			date.setFullYear(date.getFullYear() + crrCycle);
		}
		else if(crrCycleCode == "SY14000002"){
			date.setMonth((date.getMonth()) + (crrCycle * 6));
		}
		else if(crrCycleCode == "SY14000003"){
			date.setMonth((date.getMonth()) + (crrCycle * 3));
		}
		else if(crrCycleCode == "SY14000004"){
			date.setMonth((date.getMonth()) + crrCycle);
		}
		else if(crrCycleCode == "SY14000005"){
			date.setDate(date.getDate() + crrCycle);
		}

		$("#"+colId).val(setFormatDate(date));
	}
}

function setFormatDate(date){
	var d = new Date(date),
	month = '' + (d.getMonth() + 1),
	day = '' + d.getDate(),
	year = d.getFullYear();

	if (month.length < 2) {
		month = '0' + month;
	}

	if (day.length < 2) {
		day = '0' + day;
	}

	return [year, month, day].join('-');
}

/**
 * 사용 보류
 * @author shs
 */
// window.confirm = function(msg, callback, devOptions){

//     var element = document.createElement("div")
//         element.className="wrap-loading-toast";
//     document.body.appendChild(element);

//     var options = {
//         progressBar: true
//         , positionClass: "toast-center-center"
//         , timeOut : 0
//         , extendedTimeOut: 0
//         , tapToDismiss: false
//     }

//     //devOptions 추가 !
//     if(!!devOptions){
//         for(key in devOptions){
//             props[key] = devOptions[key];
//         }
//     }

//     var $toast = toastr.warning(
//         msg
//         + '<br/><br/><button id="toast_btn_confirm">확인</button>'
//         + '<button id="toast_btn_cancel">취소</button>'
//         ,'FOOSUNG'
//         , options
//     ).attr('style', 'width: 500px !important');


//     $toast.find('#toast_btn_confirm').click(fire);
//     $toast.find('#toast_btn_cancel').click(fire);

//     //fire callback function and element remove, toast 메세지 clear
//     function fire(e){
//         element.remove();
//         toastr.clear($toast, { force: true });

//         if( typeof callback == "function" && e.target.id == "toast_btn_confirm" ){
//             callback();
//         }
//     }
// }

/** 첨부파일 필수값 체크
 * ===============================================
 * @author 박기윤
 * @param  {String} dropzoneArea
 * @return  {Boolean}
 * @ex      if(atchNecessaryChk(dropzoneId)){ // 저장 };
 */

function atchNecessaryChk(dropzoneArea){
	var fileLength = dropzoneArea.getOrdArr();

	if(fileLength < 1){
		warn("필수로 업로드 해야하는 첨부파일을 확인해주세요.");
		return false;
	} else {
		return true;
	}
}



/*		계산식 관련 함수		*/
/*
 * gridObj - 계산식 변수가 있는 그리드 id
 * formId - 계산식 폼 id
 * row - 계산식 결과를 넣을 시험항목 그리드에 선택된 row
 * 
 * */
function calc(expriemGridObj, calcGridObj, formId, row, callback){
	//sNomfrmCn - 계산 수식
	var sNomfrmCn = document.getElementById(formId).querySelector("#nomfrmCn").value;
	if (sNomfrmCn == ""){
		return "";
	}

	//계산식 그리드 변수들 리스트 가져오기
	var calcNomfrmVriablGridData = AUIGrid.getGridData(calcGridObj);
	//몇개의 변수들이 있는지 체크
	var iGridDataLength = calcNomfrmVriablGridData.length;
	//변수가 없으면 return
	if (iGridDataLength == 0)
		return false;

    var rsltData = 0;
	var iNomfrmCn = 0;
	var iFailCnt = 0;
	var iVriablId = document.getElementById(formId).querySelector("#vriablId").value;//역산식 결과가 들어갈 변수명
	var rMarkCphr = document.getElementById(formId).querySelector("#markCphr").value; //실제 계산 결과값에 사용할 표기자리수(상세 변수명의 자리수를 구하기)
	
	// 계산식을 변수ID별로 결과값으로 치환. 결과값이 공백인 경우 임의로 1 셋팅
	for(i=0; i<iGridDataLength;i++){
		var myItem = AUIGrid.getItemByRowIndex(calcGridObj, i);
		var sSubVriablId = myItem["vriablId"];
		var sSubCalcResult = $.trim(myItem["vriablValue"]);
		
		sSubCalcResult = Number(( !!sSubCalcResult && sSubCalcResult.toUpperCase() == "N.A." ) ? 0 : sSubCalcResult);
		
		if (sSubCalcResult != ""){
			AUIGrid.setCellValue(calcGridObj, i, "markValue", sSubCalcResult);//소수점 표기자리수 처리한 값을 결과값으로 넣기
			
			sNomfrmCn = sNomfrmCn.replaceAll(sSubVriablId, "(" +sSubCalcResult+ "+"+getEpsilon()+")");	//수식에서 변수를 결과값으로 치환
			
			iNomfrmCn++;
		}
	}
	
	if (iGridDataLength == iNomfrmCn){
		if(!rMarkCphr){
			rMarkCphr = calcNomfrmVriablGridData[0].markCphr;
		}
		rsltData = nomfrmFnCal(sNomfrmCn, rMarkCphr, null);//수식 계산
		if (rsltData != "fail"){
			AUIGrid.forceEditingComplete(calcGridObj, null, false);
			AUIGrid.forceEditingComplete(expriemGridObj);
			AUIGrid.setCellValue(expriemGridObj, row.rowIndex, row.dataField, rsltData);
			bSave = rsltData;
		}else{
			bSave = "";
		}
	}
	
	if(typeof callback === "function"){
		callback(rsltData);
	}
}

//결과값 변경시 기준규격으로 판정 체크
function chkSdspcValue(rowItem, callback){
	var sMarkValue = ( !!rowItem.sResult && rowItem.sResult.toUpperCase() == "N.A." ) ? 0 : rowItem.sResult;
	var selJdgmntFomCode = rowItem.jdgmntFomCode;
	var sMxmmValue = rowItem.uclValue;
	var sMxmmValueSeCode = rowItem.uclValueSeCode;
	var sMummValue = rowItem.lclValue;
	var sMummValueSeCode = rowItem.lclValueSeCode;
	var sTextStdr = rowItem.textStdr;
	var sJdgCls;

    if(( !!rowItem.sResult && rowItem.sResult.toUpperCase() == "N.A." )){
        sJdgCls= "IM05000001";
    }
	
	if(sMarkValue < 0){
		sMarkValue = "0";
	}

    //판정이 없을때만 탄다.
    if(!sJdgCls){
        if(selJdgmntFomCode == "IM06000001"){	//수치형
            // 1. 최대값과 최소값 둘다 있는 경우
            if(!(sMxmmValue == "" || sMxmmValue == null) && !(sMummValue == "" || sMummValue == null)){
                // 1 - (1). 이상 / 이하
                if(sMummValueSeCode == "IM08000001" && sMxmmValueSeCode == "IM07000001"){
                    if(parseFloat(sMarkValue) >= parseFloat(sMummValue) && parseFloat(sMarkValue) <= parseFloat(sMxmmValue)){
                        sJdgCls = "IM05000001";
                    } else {
                        sJdgCls = "IM05000002";
                    }
                    //1 - (2). 이상 / 미만
                } else if(sMummValueSeCode == "IM08000001" && sMxmmValueSeCode == "IM07000002"){
                    if(parseFloat(sMarkValue) >= parseFloat(sMummValue) && parseFloat(sMarkValue) < parseFloat(sMxmmValue)){
                        sJdgCls = "IM05000001";
                    } else {
                        sJdgCls = "IM05000002";
                    }
                    //1 - (3). 초과 / 이하
                } else if(sMummValueSeCode == "IM08000002" && sMxmmValueSeCode == "IM07000001"){
                    if(parseFloat(sMarkValue) > parseFloat(sMummValue) && parseFloat(sMarkValue) <= parseFloat(sMxmmValue)){
                        sJdgCls = "IM05000001";
                    } else {
                        sJdgCls = "IM05000002";
                    }
                    //1 - (4). 초과 / 미만
                } else if(sMummValueSeCode == "IM08000002" && sMxmmValueSeCode == "IM07000002"){
                    if(parseFloat(sMarkValue) > parseFloat(sMummValue) && parseFloat(sMarkValue) < parseFloat(sMxmmValue)){
                        sJdgCls = "IM05000001";
                    } else {
                        sJdgCls = "IM05000002";
                    }
                }
                // 2. 최대값만 있는경우
            } else if(!(sMxmmValue == "" || sMxmmValue == null) && (sMummValue == "" || sMummValue == null)){
                if(sMxmmValueSeCode == "IM07000001"){
                    if(parseFloat(sMarkValue) <= parseFloat(sMxmmValue)){
                        sJdgCls = "IM05000001";
                    }else{
                        sJdgCls = "IM05000002";
                    }
                }else if(sMxmmValueSeCode == "IM07000002"){
                    if(parseFloat(sMarkValue) < parseFloat(sMxmmValue)){
                        sJdgCls = "IM05000001";
                    }else{
                        sJdgCls = "IM05000002";
                    }
                }
                // 3. 최소값만 있는경우
            }else if(!(sMummValue == "" || sMummValue == null) && (sMxmmValue == "" || sMxmmValue == null)){
                if(sMummValueSeCode == "IM08000001"){
                    if(parseFloat(sMarkValue) >= parseFloat(sMummValue)){
                        sJdgCls = "IM05000001";
                    }else{
                        sJdgCls = "IM05000002";
                    }
                }else if(sMummValueSeCode == "IM08000002"){
                    if(parseFloat(sMarkValue) > parseFloat(sMummValue)){
                        sJdgCls = "IM05000001";
                    }else{
                        sJdgCls = "IM05000002";
                    }
                }
            }else{
                sJdgCls = "IM05000003";
            }
        }else if(selJdgmntFomCode == "IM06000003"){	//텍스트
            if(!(sTextStdr =="" || sTextStdr == null)){
                if(sTextStdr == sMarkValue){
                    sJdgCls = "IM05000001";
                }else{
                    sJdgCls = "IM05000002";
                }
            }else{
                sJdgCls = "IM05000003";
            }
        }else if(selJdgmntFomCode == "IM06000004"){	//기준없음
            sJdgCls = "IM05000003";
        }

    }

	if(typeof callback === "function"){
		callback(sJdgCls);
	}
}


/*
 *  - Number.epsilon
 *  Number 형으로 표현될 수 있는 1과 1보다 큰 값 중에서 가장 작은 값의 차입니다. 
 *  
 *  IE에서는 지원하지 않아서 함수로 만들어 놓음. 
 *  Number.epsilon과 같은 기능임.
 * */
function getEpsilon() {
	var e = 1.0;
	while ( ( 1.0 + 0.5 * e ) !== 1.0 )
	  e *= 0.5;
	return e;
}

function chkItemList(chkItemList){
	  for(var i = 0; i < chkItemList.length; i++){
		  var row = chkItemList[i];
		  
			  
	  }
}

/*
 * RDMS Viwer 호출
 * 
 * 
 */

function callRDMSViwer(resultObj,gubun){
	var chkItemList = AUIGrid.getCheckedRowItemsAll(resultObj);

	if (chkItemList.length <= 0) {
		alert('PDF Viewer를 사용하기 위한 시험 항목을 1개 이상 체크해야 합니다.');
		return false;
	} else {
	    //RDMS 원본, 수정본 구분 값 세팅
        chkItemList.forEach(function(v){
            v.type = gubun;
        });
    }
	
	customAjax({
		"url" : "/com/getPdfViewerBinderitemvalueId.lims",
		"data" : chkItemList,
		"successFunc" : function(result) {
			if(!!result) {
				var binderitemvalueIdCount = 0;
				var binderitemvalueIdArr = new Array();
				for(var i = 0; i < result.length; i++) {
					if(result[i].binderitemvalueId != null) {
						binderitemvalueIdArr[i] = result[i].binderitemvalueId;
						binderitemvalueIdCount++;
					}
				}

				if(binderitemvalueIdCount == 0) {
					alert('선택하신 시험항목 리스트에 등록되어있는 RDMS가 없습니다.');
					return false;
				} else {
					var mapForm = document.createElement("form");
				     	mapForm.target = "PdfViewerPopupM";
				        mapForm.name = "windowOpen_PdfViewerPopupM"
					    mapForm.method = "POST";
					    mapForm.action = "/src/PdfViewerPopupM.lims";
					
					//binderitemvalue_id 모은 문자열
					var mapInput = document.createElement("input");
					    mapInput.type = "hidden";
					    mapInput.name = "param";
					    mapInput.value = binderitemvalueIdArr;
					    mapForm.appendChild(mapInput);
					    
					//사업장 코드
				    var bplcInput = document.createElement("input");
					    bplcInput.type = "hidden";
					    bplcInput.name = "bplcCode";
					    bplcInput.value = result[0].bplcCode;
					    mapForm.appendChild(bplcInput);

                    //o = 원본 , c = 복사본
                    var type = document.createElement("input");
                        type.type = "hidden";
                        type.name = "type";
                        type.value = result[0].type;
                        mapForm.appendChild(type);
					    
					document.body.appendChild(mapForm);

                    //PdfViewerPopupM jsp 페이지 호출
					mapForm.submit();
			        $("form[name=windowOpen_PdfViewerPopupM]").remove();
				}
			}
		}
	})
}


// dialog Reset Ev
/**
 * @param id
 * 리셋 버튼이 포함된 td캡션 내부의 value를 null로 입력
 * @returns
 */
function dialogReset(id){
	var param = $("#"+id)[0].parentElement.children
	
	for(var i=0; i< param.length; i++){
		param[i].value = "";	
	}
}

/**
 * AUIGrid DIV size 변경시
 * AUIGrid resize 이벤트 부여
 * 
 * @author shs
 */
function gridReSizeEvent(gridId){

    if(browserCheck() === 'MS IE'){
        return;
    }

    var auiGrid  = document.querySelector(gridId);
        auiGrid.style.resize = "vertical"; //style 선언
        auiGrid.style.overflowY = "auto";
        auiGrid.style.overflowX = "hidden";

    var observer = new MutationObserver(function(mutations) {
        for(var k=0; k<mutations.length; k++){
            var mutation = mutations[k];
            AUIGrid.resize("#" + mutation.target.id);
            
            // dialog에서의 grid일 경우 size를 늘렸을 때, popup을 다시 정렬한다.
            var popupElementId = $(mutation.target).closest('.popup').prop('id');
            if(popupElementId){
                popupCenter(popupElementId.replace('popup_',''));
            }
        }
    });

    // 감시할 대상 등록
    observer.observe(auiGrid, {attributes: true});
}

function browserCheck() {

    var agent = navigator.userAgent.toLowerCase();
    
    switch (true) {
        case agent.indexOf("edge") > -1:
            return "MS Edge";
        case agent.indexOf("edg/") > -1:
            return "Edge ( chromium based)";
        case agent.indexOf("opr") > -1 && !!window.opr:
            return "Opera";
        case agent.indexOf("chrome") > -1 && !!window.chrome:
            return "Chrome";
        case agent.indexOf("trident") > -1:
            return "MS IE";
        case agent.indexOf("firefox") > -1:
            return "Mozilla Firefox";
        case agent.indexOf("safari") > -1:
            return "Safari";
        default:
            return "other";
    }
}

/**
 * 결재자 명을 string으로 만들어서 반환합니다.
 * @param {object[]} list - 결재자 list
 * @return {string} 결재자 명
 */
function getSanctnerNm(list) {
    return list
            .map(function (user) {
                return user.userNm;
            })
            .join(' > ');
}

/**
 * 
 * selectbox element의 선택된 option text를 return합니다.
 * 
 * @param {HTMLElement} element - html element
 * @return {string}
 */
function getSeletedOptionText(element) {
    if (element.nodeName !== 'SELECT') {
        throw 'selectbox가 아니면 option text 값을 반환할 수 없습니다.'
    }
    return element.selectedIndex === -1 ? '' : element[element.selectedIndex].text;
}

/**
 * 이 생성자 함수는 visible(display)을 controll 해줍니다.
 * 기본적으로 HTMLElement.dataset을 이용하여 display 속성을 조작한다.
 * 
 * example -
 *      [html tag]
 *      <button type="button" data-visible-code=["CM01000005"]>검토</button>
 *      <button type="button" data-visible-code=["CM01000001","CM01000004"]>결재상신</button>
 *      
 *      [js code]
 *      var visibleSupport = new VisibleSupport('data-visible-code');
 *      visibleSupport.displayOfCode('CM01000005'); -> 검토 button만 display. 나머지 display none
 * 
 * @param dataset
 * @author shs
 */
function VisibleSupport(dataset) {
    this.dataset = dataset;
    this.datasetSelector = '['+this.dataset+']';
    this.targetElements = document.querySelectorAll(this.datasetSelector);

    this.showAll = function () {
        for (var i = 0; i < this.targetElements.length; i++) {
            this.targetElements[i].style.display = '';
        }
    };
    
    this.hideAll = function () {
        for (var i = 0; i < this.targetElements.length; i++) {
            this.targetElements[i].style.display = 'none';
        }
    };
    
    this.displayOfCode = function (paramCode) {
        for (var i = 0; i < this.targetElements.length; i++) {
            var element = this.targetElements[i];
            var datasetValue = element.getAttribute(this.dataset);
            if (!!!datasetValue) {
                throw 'dataset value가 유효하지 않습니다.'
            }
            
            var datasetCodes = JSON.parse(datasetValue);
            if (!Array.isArray(datasetCodes)) {
                throw 'dataset value가 Array가 아닙니다.'
            }

            elementDisplayChange(element, datasetCodes, paramCode);
        }
    };

    function elementDisplayChange(element, datasetCodes, paramCode) {
        var matches = datasetCodes.filter(function (code) {
            return code === paramCode;
        });
        (matches.length > 0) ? element.style.display = '' : element.style.display = 'none'
    }
}

// accordion event
function accordionEvent() {
    document.querySelector('#sub_wrap').addEventListener('click', function (e) {
        if (e.target.classList.contains('accordion')) {
            e.target.classList.toggle("active");
            
            var panel = e.target.nextElementSibling;
                panel.style.display = (panel.style.display === '') ? "none" : '';
                
            resizeAllAuiGrid();
        }
    });
}

// grid 전체 resize
function resizeAllAuiGrid() {
    var grids = document.querySelectorAll('.aui-grid');
    for( var i=0; i<grids.length; i++ ){
        var auiGrid = grids[i]; //auigrid 가 rendering되어있는 element
        var gridId = auiGrid.parentElement.id; //auigrid를 선언하는 DIV임
        AUIGrid.resize("#" + gridId);
    }
}

/**
 * header부분 총 결재 건수와 클릭시 메뉴별 결재 건수에 대한 기능을 담당하는 Class 입니다.
 * 
 * @param element html element
 */
function SanctnCountBox(element){
    this.element = element;
    this.totalCountCounter = new Counter('[data-sanctn-totalcount-id]');

    this.setHrefEvent = function () {
        this.element.addEventListener('click', function (e) {
            var url = e.target.getAttribute('data-url');
            if (!!url) {
                location.href = url;
            }
        });
    };
    
    this.setSanctnCnt = function () {
        
        var thiz = this;
        
        customAjax({
       		url: "/com/getSanctnCount.lims"
       	}).then(function (countList) {
               
            var totCount = countList
                .filter(function (sanctn) {
                    return sanctn.sanctnKndCode === 'TOTAL';
                })
                .map(function (sanctn) {
                    return sanctn.sanctnCount;
                }).toString();
            
            // total count set
            thiz.totalCountCounter.counting(totCount);
       		
       		var htmlString = countList
       			.filter(function (sanctn) {
       				return sanctn.sanctnKndCode !== 'TOTAL';
       			})
       			.map(function (sanctn) {
       				return '<span data-code="' + sanctn.sanctnKndCode + '" data-url="' + sanctn.menuUrl + '">' + sanctn.sanctnKndCodeNm + '<span>' + sanctn.sanctnCount + ' 건</span></span>';
       			})
       			.join('');
       		
       		thiz.element.innerHTML += htmlString;
       	});
    };

    this.toggle = function () {
        this.element.classList.toggle('sanctnCountBox-hide');
        this.element.classList.toggle('sanctnCountBox-show');
    };
}

/**
 * 어떠한 html 객체에 대해서 innerHtml을 통해 정적인 숫자를 동적으로 숫자가 증가하는 것처럼 보이게 만들어준다.
 * 0부터 어떤 숫자까지 점진적으로 증가시킴.
 * 
 * @param targetSelector - querySelector에 사용될 expression 
 */
function Counter(targetSelector) {
    this.count = 0;
    this.diff = 0;
    this.targetEl = document.querySelector(targetSelector);
    this.timer = null;
    
    this.counting = function(number) {
        var thiz = this;
        var target_count = this.toNumber(number);
        this.diff = target_count - this.count;
    
        if(this.diff > 0) {
            this.count += Math.ceil(this.diff / 30);
        }
    
        this.targetEl.innerHTML = this.count;
        
        if(this.count < target_count) {

            this.timer = setTimeout(function () {
                thiz.counting(number);
            }, 20);
            
        } else {
            clearTimeout(this.timer);
        }
    };

    this.toNumber = function (stringNumber) {
        return parseInt(stringNumber.replace(/[^\d]+/g, ''));
    };
}

/**
 * @author gwpark
 * @comment 입력폼의 특정 elements의 속성을 동적으로 컨트롤하기 위한 함수
 *          동적으로 컨트롤할 element가 입력폼의 element 중 대부분을 차지하는 경우에 용이
 * @param {Object} obj {
 *      {String} formId : 입력폼 id
 *      {Array} ignoreElName : 무시할 element의 name이 담긴 배열
 *      {Boolaen} disableSet : disabled 속성 부여 여부
 *      {Boolean} requireSet : required 속성 부여 여부
 *      {function} callbck : callback으로 동작시킬 함수
 * }
 */
function formMostElAttrCtrl(obj) {
    var formId = obj.formId;
    var ignoreElName = obj.ignoreElName;
    var disableSet = (!!obj.disableSet) ? obj.disableSet : false;
    var requireSet = (!!obj.requireSet) ? obj.requireSet : false;
    var callback = obj.callback;

    var formEl = document.getElementById(formId).elements;
    for (var i = 0; i < formEl.length; i++) {
        if (!!ignoreElName) {
            if (ignoreElName.includes(formEl[i].name) == false) {
                formEl[i].disabled = disableSet;
                formEl[i].required = requireSet;
                if (requireSet == true) {
                    formEl[i].parentElement.previousElementSibling.classList.add('necessary');
                } else {
                    formEl[i].parentElement.previousElementSibling.classList.remove('necessary');
                }
            }
        } else {
            formEl[i].disabled = disableSet;
            formEl[i].required = requireSet;
            if (requireSet == true) {
                formEl[i].parentElement.previousElementSibling.classList.add('necessary');
            } else {
                formEl[i].parentElement.previousElementSibling.classList.remove('necessary');
            }
        }
    }

    if (!!callback && typeof callback === 'function') {
        callback();
    }
}


/**
 * @author gwpark
 * @comment 입력폼의 특정 elements의 속성을 동적으로 컨트롤하기 위한 함수
 *          동적으로 컨트롤할 element가 입력폼의 element 중 일부만을 차지하는 경우에 용이
 * @param {Object} obj {
 *      {String} formId : 입력폼 id
 *      {Array} targetElName : 동적 컨트롤할 element의 name이 담긴 배열
 *      {Boolaen} disableSet : disabled 속성 부여 여부
 *      {Boolean} requireSet : required 속성 부여 여부
 *      {function} callbck : callback으로 동작시킬 함수
 * }
 */
function formLeastElAttrCtrl(obj) {
    var formId = obj.formId;
    var targetElName = obj.targetElName;
    var disableSet = (!!obj.disableSet) ? obj.disableSet : false;
    var requireSet = (!!obj.requireSet) ? obj.requireSet : false;
    var callback = obj.callback;

    var formEl = document.getElementById(formId).elements;
    for (var i = 0; i < formEl.length; i++) {
        if (!!targetElName) {
            if (targetElName.includes(formEl[i].name) == true) {
                formEl[i].disabled = disableSet;
                formEl[i].required = requireSet;
                if (requireSet == true) {
                    formEl[i].parentElement.previousElementSibling.classList.add('necessary');
                } else {
                    formEl[i].parentElement.previousElementSibling.classList.remove('necessary');
                }
            }
        }
    }

    if (!!callback && typeof callback === 'function') {
        callback();
    }
}
