/**
 * DNA 추출 중 화면의 엑셀 데이터를 Json형태로 임포트하는 Js
 * (sheetJs에서 엑셀 데이터를 Object Array로 Import하는 부분을 옮겨와 부분 수정)
 */
var DPOEI = DPOEI || (function (){

	var cfregex = /\[[=<>]/;
	var cfregex2 = /\[([=<>]*)(-?\d+\.?\d*)\]/;
	var closeparen = /\).*[0#]/;
	
	function isgeneral(s, i) { return s.length >= 7 + i && (s.charCodeAt(i)|32) === 103 && (s.charCodeAt(i+1)|32) === 101 && (s.charCodeAt(i+2)|32) === 110 && (s.charCodeAt(i+3)|32) === 101 && (s.charCodeAt(i+4)|32) === 114 && (s.charCodeAt(i+5)|32) === 97 && (s.charCodeAt(i+6)|32) === 108; }
	function general_fmt_int(v, opts) { return ""+v; }
	function _strrev(x) { var o = "", i = x.length-1; while(i>=0) o += x.charAt(i--); return o; }
	function fill(c,l) { var o = ""; while(o.length < l) o+=c; return o; }
	function pad0(v,d){var t=""+v; return t.length>=d?t:fill('0',d-t.length)+t;}
	function pad_(v,d){var t=""+v;return t.length>=d?t:fill(' ',d-t.length)+t;}
	function rpad_(v,d){var t=""+v; return t.length>=d?t:t+fill(' ',d-t.length);}
	function pad0r1(v,d){var t=""+Math.round(v); return t.length>=d?t:fill('0',d-t.length)+t;}
	function pad0r2(v,d){var t=""+v; return t.length>=d?t:fill('0',d-t.length)+t;}
	function DnPrepO_encode_row(row) { return "" + (row + 1); }
	function DnPrepO_encode_col(col) { var s=""; for(++col; col; col=Math.floor((col-1)/26)) s = String.fromCharCode(((col-1)%26) + 65) + s; return s; }
	var p2_32 = Math.pow(2,32);
	function pad0r(v,d){if(v>p2_32||v<-p2_32) return pad0r1(v,d); var i = Math.round(v); return pad0r2(i,d); }
	function hashq(str) {
		var o = "", cc;
		for(var i = 0; i != str.length; ++i) switch((cc=str.charCodeAt(i))) {
			case 35: break;
			case 63: o+= " "; break;
			case 48: o+= "0"; break;
			default: o+= String.fromCharCode(cc);
		}
		return o;
	}
	
	function write_num_f1(r, aval, sign) {
		var den = parseInt(r[4]), rr = Math.round(aval * den), base = Math.floor(rr/den);
		var myn = (rr - base*den), myd = den;
		return sign + (base === 0 ? "" : ""+base) + " " + (myn === 0 ? fill(" ", r[1].length + 1 + r[4].length) : pad_(myn,r[1].length) + r[2] + "/" + r[3] + pad0(myd,r[4].length));
	}
	
	function rnd(val, d) { var dd = Math.pow(10,d); return ""+(Math.round(val * dd)/dd); }
	
	function commaify(s) {
		if(s.length <= 3) return s;
		var j = (s.length % 3), o = s.substr(0,j);
		for(; j!=s.length; j+=3) o+=(o.length > 0 ? "," : "") + s.substr(j,3);
		return o;
	}
	
	function frac(x, D, mixed) {
		var sgn = x < 0 ? -1 : 1;
		var B = x * sgn;
		var P_2 = 0, P_1 = 1, P = 0;
		var Q_2 = 1, Q_1 = 0, Q = 0;
		var A = Math.floor(B);
		while(Q_1 < D) {
			A = Math.floor(B);
			P = A * P_1 + P_2;
			Q = A * Q_1 + Q_2;
			if((B - A) < 0.0000000005) break;
			B = 1 / (B - A);
			P_2 = P_1; P_1 = P;
			Q_2 = Q_1; Q_1 = Q;
		}
		if(Q > D) { Q = Q_1; P = P_1; }
		if(Q > D) { Q = Q_2; P = P_2; }
		if(!mixed) return [0, sgn * P, Q];
		if(Q===0) throw "Unexpected state: "+P+" "+P_1+" "+P_2+" "+Q+" "+Q_1+" "+Q_2;
		var q = Math.floor(sgn * P/Q);
		return [q, sgn*P - q*Q, Q];
	}
	
	function DnPrepO_safe_format_cell(cell, v) {
		if(cell.z !== undefined) try { return (cell.w = SSF.format(cell.z, v)); } catch(e) { }
		if(!cell.XF) return v;
		try { return (cell.w = SSF.format(cell.XF.ifmt||0, v)); } catch(e) { return ''+v; }
	}
	
	function DnPrepO_format_cell(cell, v) {
		if(cell == null || cell.t == null) return "";
		if(cell.w !== undefined) return cell.w;
		if(v === undefined) return DnPrepO_safe_format_cell(cell, cell.v);
		return DnPrepO_safe_format_cell(cell, v);
	}
	
	function DnPrepO_sheet_to_json(sheet, opts, headerRow){
		var val, row, range, header = 0, offset = 1, r, hdr = [], isempty, R, C, v;
		var o = opts != null ? opts : {};
		var raw = o.raw;
		if(sheet == null || sheet["!ref"] == null) return [];
		range = o.range !== undefined ? o.range : sheet["!ref"];
		if(o.header === 1) header = 1;
		else if(o.header === "A") header = 2;
		else if(Array.isArray(o.header)) header = 3;
		switch(typeof range) {
			case 'string': r = DnPrepO_safe_decode_range(range); break;
			case 'number': r = DnPrepO_safe_decode_range(sheet["!ref"]); r.s.r = range; break;
			default: r = range;
		}
		if(header > 0) offset = 0;
		var rr = DnPrepO_encode_row(r.s.r);
		var cols = new Array(r.e.c-r.s.c+1);
		var out = new Array(r.e.r-r.s.r-offset+1);
		var outi = 0;
		for(C = r.s.c; C <= r.e.c; ++C) {
			cols[C] = DnPrepO_encode_col(C);
			if(headerRow !== undefined && headerRow !== null) rr = headerRow;
			val = sheet[cols[C] + rr];
			switch(header) {
				case 1: hdr[C] = C; break;
				case 2: hdr[C] = cols[C]; break;
				case 3: hdr[C] = o.header[C - r.s.c]; break;
				default:
					if(val === undefined) continue;
					if(headerRow !== undefined && headerRow !== null) hdr[C] = dnPrepOingColumnParse(DnPrepO_format_cell(val));//헤더 텍스트 설정
					else hdr[C] =DnPrepO_format_cell(val);//
			}
		}
	
		for (R = r.s.r + offset; R <= r.e.r; ++R) {
			rr = DnPrepO_encode_row(R);
			isempty = true;
			if(header === 1) row = [];
			else {
				row = {};
				if(Object.defineProperty) Object.defineProperty(row, '__rowNum__', {value:R, enumerable:false});
				else row.__rowNum__ = R;
			}
			for (C = r.s.c; C <= r.e.c; ++C) {
				val = sheet[cols[C] + rr];
				if(val === undefined || val.t === undefined) continue;
				v = val.v;
				switch(val.t){
					case 'e': continue;
					case 's': break;
					case 'b': case 'n': break;
					default: throw 'unrecognized type ' + val.t;
				}
				if(v !== undefined) {
					row[hdr[C]] = raw ? v :DnPrepO_format_cell(val,v);//
					isempty = false;
				}
			}
			if(isempty === false || header === 1) out[outi++] = row;
		}
		out.length = outi;
		return out;
	}
	
	function dnPrepOingColumnParse(value){//헤더 텍스트 설정(Vo에 맞게)
		value = value.replace(/\s/gi,"");
		switch(value){
			case "Location": value = "loct";	break;
			case "260Raw":	value = "p260raw";	break;
			case "280Raw":	value = "p280raw";	break;
			case "230Raw":	value = "p230raw";	break;
			case "320Raw":	value = "p320raw";	break;
			case "260": value = "p260";	break;
			case "280": value = "p280";	break;
			case "230": value = "p230";	break;
			case "260/280":	value = "pur";	break;
			case "260/230":	value = "p260230";	break;
			case "ng/μL": value = "cns"; break;
			case "SampleRead#" :	value = "smpMngNo";	break;
			case "SmpMngNo" :	value = "smpMngNo";	break;
		}
		return value;
	}
	
	function DnPrepO_sheet_to_row_object_array(sheet, opts, headerRow) { return DnPrepO_sheet_to_json(sheet, opts != null ? opts : {}, headerRow); }
	
	function DnPrepO_safe_decode_range(range) {
		var o = {s:{c:0,r:0},e:{c:0,r:0}};
		var idx = 0, i = 0, cc = 0;
		var len = range.length;
		for(idx = 0; i < len; ++i) {
			if((cc=range.charCodeAt(i)-64) < 1 || cc > 26) break;
			idx = 26*idx + cc;
		}
		o.s.c = --idx;
	
		for(idx = 0; i < len; ++i) {
			if((cc=range.charCodeAt(i)-48) < 0 || cc > 9) break;
			idx = 10*idx + cc;
		}
		o.s.r = --idx;
	
		if(i === len || range.charCodeAt(++i) === 58) { o.e.c=o.s.c; o.e.r=o.s.r; return o; }
	
		for(idx = 0; i != len; ++i) {
			if((cc=range.charCodeAt(i)-64) < 1 || cc > 26) break;
			idx = 26*idx + cc;
		}
		o.e.c = --idx;
	
		for(idx = 0; i != len; ++i) {
			if((cc=range.charCodeAt(i)-48) < 0 || cc > 9) break;
			idx = 10*idx + cc;
		}
		o.e.r = --idx;
		return o;
	}
	
	function format(fmt,v,o) {
		fixopts(o != null ? o : (o=[]));
		var sfmt = "";
		switch(typeof fmt) {
			case "string": sfmt = fmt; break;
			case "number": sfmt = (o.table != null ? o.table : table_fmt)[fmt]; break;
		}
		if(isgeneral(sfmt,0)) return general_fmt(v, o);
		var f = choose_fmt(sfmt, v);
		if(isgeneral(f[1])) return general_fmt(v, o);
		if(v === true) v = "TRUE"; else if(v === false) v = "FALSE";
		else if(v === "" || v == null) return "";
		return eval_fmt(f[1], v, o, f[0]);
	}
	
	function choose_fmt(f, v) {
		var fmt = split_fmt(f);
		var l = fmt.length, lat = fmt[l-1].indexOf("@");
		if(l<4 && lat>-1) --l;
		if(fmt.length > 4) throw "cannot find right format for |" + fmt + "|";
		if(typeof v !== "number") return [4, fmt.length === 4 || lat>-1?fmt[fmt.length-1]:"@"];
		switch(fmt.length) {
			case 1: fmt = lat>-1 ? ["General", "General", "General", fmt[0]] : [fmt[0], fmt[0], fmt[0], "@"]; break;
			case 2: fmt = lat>-1 ? [fmt[0], fmt[0], fmt[0], fmt[1]] : [fmt[0], fmt[1], fmt[0], "@"]; break;
			case 3: fmt = lat>-1 ? [fmt[0], fmt[1], fmt[0], fmt[2]] : [fmt[0], fmt[1], fmt[2], "@"]; break;
			case 4: break;
		}
		var ff = v > 0 ? fmt[0] : v < 0 ? fmt[1] : fmt[2];
		if(fmt[0].indexOf("[") === -1 && fmt[1].indexOf("[") === -1) return [l, ff];
		if(fmt[0].match(cfregex) != null || fmt[1].match(cfregex) != null) {
			var m1 = fmt[0].match(cfregex2);
			var m2 = fmt[1].match(cfregex2);
			return chkcond(v, m1) ? [l, fmt[0]] : chkcond(v, m2) ? [l, fmt[1]] : [l, fmt[m1 != null && m2 != null ? 2 : 1]];
		}
		return [l, ff];
	}
	
	function chkcond(v, rr) {
		if(rr == null) return false;
		var thresh = parseFloat(rr[2]);
		switch(rr[1]) {
			case "=":  if(v == thresh) return true; break;
			case ">":  if(v >  thresh) return true; break;
			case "<":  if(v <  thresh) return true; break;
			case "<>": if(v != thresh) return true; break;
			case ">=": if(v >= thresh) return true; break;
			case "<=": if(v <= thresh) return true; break;
		}
		return false;
	}
	
	function split_fmt(fmt) {
		var out = [];
		var in_str = false, cc;
		for(var i = 0, j = 0; i < fmt.length; ++i) switch((cc=fmt.charCodeAt(i))) {
			case 34: /* '"' */
				in_str = !in_str; break;
			case 95: case 42: case 92: /* '_' '*' '\\' */
				++i; break;
			case 59: /* ';' */
				out[out.length] = fmt.substr(j,i-j);
				j = i+1;
		}
		out[out.length] = fmt.substr(j);
		if(in_str === true) throw new Error("Format |" + fmt + "| unterminated string ");
		return out;
	}
	
	function eval_fmt(fmt, v, opts, flen) {
		var out = [], o = "", i = 0, c = "", lst='t', q, dt, j, cc;
		var hr='H';
		/* Tokenize */
		while(i < fmt.length) {
			switch((c = fmt[i])) {
				case 'G': /* General */
					if(!isgeneral(fmt, i)) throw new Error('unrecognized character ' + c + ' in ' +fmt);
					out[out.length] = {t:'G', v:'General'}; i+=7; break;
				case '"': /* Literal text */
					for(o="";(cc=fmt.charCodeAt(++i)) !== 34 && i < fmt.length;) o += String.fromCharCode(cc);
					out[out.length] = {t:'t', v:o}; ++i; break;
				case '\\': var w = fmt[++i], t = (w === "(" || w === ")") ? w : 't';
					out[out.length] = {t:t, v:w}; ++i; break;
				case '_': out[out.length] = {t:'t', v:" "}; i+=2; break;
				case '@': /* Text Placeholder */
					out[out.length] = {t:'T', v:v}; ++i; break;
				case 'B': case 'b':
					if(fmt[i+1] === "1" || fmt[i+1] === "2") {
	          if(dt==null) { dt=parse_date_code(v, opts, fmt[i+1] === "2"); if(dt==null) return ""; }
						out[out.length] = {t:'X', v:fmt.substr(i,2)}; lst = c; i+=2; break;
					}
					/* falls through */
				case 'M': case 'D': case 'Y': case 'H': case 'S': case 'E':
					c = c.toLowerCase();
					/* falls through */
				case 'm': case 'd': case 'y': case 'h': case 's': case 'e': case 'g':
					if(v < 0) return "";
					if(dt==null) { dt=parse_date_code(v, opts); if(dt==null) return ""; }
					o = c; while(++i<fmt.length && fmt[i].toLowerCase() === c) o+=c;
					if(c === 'm' && lst.toLowerCase() === 'h') c = 'M'; /* m = minute */
					if(c === 'h') c = hr;
					out[out.length] = {t:c, v:o}; lst = c; break;
				case 'A':
					q={t:c, v:"A"};
					if(dt==null) dt=parse_date_code(v, opts);
	        if(fmt.substr(i, 3) === "A/P") { if(dt!=null) q.v = dt.H >= 12 ? "P" : "A"; q.t = 'T'; hr='h';i+=3;}
	        else if(fmt.substr(i,5) === "AM/PM") { if(dt!=null) q.v = dt.H >= 12 ? "PM" : "AM"; q.t = 'T'; i+=5; hr='h'; }
					else { q.t = "t"; ++i; }
					if(dt==null && q.t === 'T') return "";
					out[out.length] = q; lst = c; break;
				case '[':
					o = c;
					while(fmt[i++] !== ']' && i < fmt.length) o += fmt[i];
					if(o.substr(-1) !== ']') throw 'unterminated "[" block: |' + o + '|';
					if(o.match(abstime)) {
						if(dt==null) { dt=parse_date_code(v, opts); if(dt==null) return ""; }
						out[out.length] = {t:'Z', v:o.toLowerCase()};
					} else { o=""; }
					break;
				/* Numbers */
				case '.':
					if(dt != null) {
						o = c; while((c=fmt[++i]) === "0") o += c;
						out[out.length] = {t:'s', v:o}; break;
					}
					/* falls through */
				case '0': case '#':
					o = c; while("0#?.,E+-%".indexOf(c=fmt[++i]) > -1 || c=='\\' && fmt[i+1] == "-" && "0#".indexOf(fmt[i+2])>-1) o += c;
					out[out.length] = {t:'n', v:o}; break;
				case '?':
					o = c; while(fmt[++i] === c) o+=c;
					q={t:c, v:o}; out[out.length] = q; lst = c; break;
				case '*': ++i; if(fmt[i] == ' ' || fmt[i] == '*') ++i; break; // **
				case '(': case ')': out[out.length] = {t:(flen===1?'t':c), v:c}; ++i; break;
				case '1': case '2': case '3': case '4': case '5': case '6': case '7': case '8': case '9':
					o = c; while("0123456789".indexOf(fmt[++i]) > -1) o+=fmt[i];
					out[out.length] = {t:'D', v:o}; break;
				case ' ': out[out.length] = {t:c, v:c}; ++i; break;
				default:
					if(",$-+/():!^&'~{}<>=€acfijklopqrtuvwxz".indexOf(c) === -1) throw new Error('unrecognized character ' + c + ' in ' + fmt);
					out[out.length] = {t:'t', v:c}; ++i; break;
			}
		}
		var bt = 0, ss0 = 0, ssm;
		for(i=out.length-1, lst='t'; i >= 0; --i) {
			switch(out[i].t) {
				case 'h': case 'H': out[i].t = hr; lst='h'; if(bt < 1) bt = 1; break;
				case 's':
					if((ssm=out[i].v.match(/\.0+$/))) ss0=Math.max(ss0,ssm[0].length-1);
					if(bt < 3) bt = 3;
				/* falls through */
				case 'd': case 'y': case 'M': case 'e': lst=out[i].t; break;
				case 'm': if(lst === 's') { out[i].t = 'M'; if(bt < 2) bt = 2; } break;
				case 'X': if(out[i].v === "B2");
					break;
				case 'Z':
					if(bt < 1 && out[i].v.match(/[Hh]/)) bt = 1;
					if(bt < 2 && out[i].v.match(/[Mm]/)) bt = 2;
					if(bt < 3 && out[i].v.match(/[Ss]/)) bt = 3;
			}
		}
		switch(bt) {
			case 0: break;
			case 1:
				if(dt.u >= 0.5) { dt.u = 0; ++dt.S; }
				if(dt.S >=  60) { dt.S = 0; ++dt.M; }
				if(dt.M >=  60) { dt.M = 0; ++dt.H; }
				break;
			case 2:
				if(dt.u >= 0.5) { dt.u = 0; ++dt.S; }
				if(dt.S >=  60) { dt.S = 0; ++dt.M; }
				break;
		}
		/* replace fields */
		var nstr = "", jj;
		for(i=0; i < out.length; ++i) {
			switch(out[i].t) {
				case 't': case 'T': case ' ': case 'D': break;
				case 'X': out[i] = undefined; break;
				case 'd': case 'm': case 'y': case 'h': case 'H': case 'M': case 's': case 'e': case 'b': case 'Z':
					out[i].v = write_date(out[i].t.charCodeAt(0), out[i].v, dt, ss0);
					out[i].t = 't'; break;
				case 'n': case '(': case '?':
					jj = i+1;
					while(out[jj] != null && (
						(c=out[jj].t) === "?" || c === "D" ||
						(c === " " || c === "t") && out[jj+1] != null && (out[jj+1].t === '?' || out[jj+1].t === "t" && out[jj+1].v === '/') ||
						out[i].t === '(' && (c === ' ' || c === 'n' || c === ')') ||
						c === 't' && (out[jj].v === '/' || '$€'.indexOf(out[jj].v) > -1 || out[jj].v === ' ' && out[jj+1] != null && out[jj+1].t == '?')
					)) {
						out[i].v += out[jj].v;
						out[jj] = undefined; ++jj;
					}
					nstr += out[i].v;
					i = jj-1; break;
				case 'G': out[i].t = 't'; out[i].v = general_fmt(v,opts); break;
			}
		}
		var vv = "", myv, ostr;
		if(nstr.length > 0) {
			myv = (v<0&&nstr.charCodeAt(0) === 45 ? -v : v); /* '-' */
			ostr = write_num(nstr.charCodeAt(0) === 40 ? '(' : 'n', nstr, myv); /* '(' */
			jj=ostr.length-1;
			var decpt = out.length;
			for(i=0; i < out.length; ++i) if(out[i] != null && out[i].v.indexOf(".") > -1) { decpt = i; break; }
			var lasti=out.length;
			if(decpt === out.length && ostr.indexOf("E") === -1) {
				for(i=out.length-1; i>= 0;--i) {
					if(out[i] == null || 'n?('.indexOf(out[i].t) === -1) continue;
					if(jj>=out[i].v.length-1) { jj -= out[i].v.length; out[i].v = ostr.substr(jj+1, out[i].v.length); }
					else if(jj < 0) out[i].v = "";
					else { out[i].v = ostr.substr(0, jj+1); jj = -1; }
					out[i].t = 't';
					lasti = i;
				}
				if(jj>=0 && lasti<out.length) out[lasti].v = ostr.substr(0,jj+1) + out[lasti].v;
			}
			else if(decpt !== out.length && ostr.indexOf("E") === -1) {
				jj = ostr.indexOf(".")-1;
				for(i=decpt; i>= 0; --i) {
					if(out[i] == null || 'n?('.indexOf(out[i].t) === -1) continue;
					j=out[i].v.indexOf(".")>-1&&i===decpt?out[i].v.indexOf(".")-1:out[i].v.length-1;
					vv = out[i].v.substr(j+1);
					for(; j>=0; --j) {
						if(jj>=0 && (out[i].v[j] === "0" || out[i].v[j] === "#")) vv = ostr[jj--] + vv;
					}
					out[i].v = vv;
					out[i].t = 't';
					lasti = i;
				}
				if(jj>=0 && lasti<out.length) out[lasti].v = ostr.substr(0,jj+1) + out[lasti].v;
				jj = ostr.indexOf(".")+1;
				for(i=decpt; i<out.length; ++i) {
					if(out[i] == null || 'n?('.indexOf(out[i].t) === -1 && i !== decpt ) continue;
					j=out[i].v.indexOf(".")>-1&&i===decpt?out[i].v.indexOf(".")+1:0;
					vv = out[i].v.substr(0,j);
					for(; j<out[i].v.length; ++j) {
						if(jj<ostr.length) vv += ostr[jj++];
					}
					out[i].v = vv;
					out[i].t = 't';
					lasti = i;
				}
			}
		}
		for(i=0; i<out.length; ++i) if(out[i] != null && 'n(?'.indexOf(out[i].t)>-1) {
			myv = (flen >1 && v < 0 && i>0 && out[i-1].v === "-" ? -v:v);
			out[i].v = write_num(out[i].t, out[i].v, myv);
			out[i].t = 't';
		}
		var retval = "";
		for(i=0; i !== out.length; ++i) if(out[i] != null) retval += out[i].v;
		return retval;
	}
	
	function parse_date_code(v,opts,b2) {
		if(v > 2958465 || v < 0) return null;
		var date = (v|0), time = Math.floor(86400 * (v - date)), dow=0;
		var dout=[];
		var out={D:date, T:time, u:86400*(v-date)-time,y:0,m:0,d:0,H:0,M:0,S:0,q:0};
		if(Math.abs(out.u) < 1e-6) out.u = 0;
		fixopts(opts != null ? opts : (opts=[]));
		if(opts.date1904) date += 1462;
		if(out.u > 0.999) {
			out.u = 0;
			if(++time == 86400) { time = 0; ++date; }
		}
		if(date === 60) {dout = b2 ? [1317,10,29] : [1900,2,29]; dow=3;}
		else if(date === 0) {dout = b2 ? [1317,8,29] : [1900,1,0]; dow=6;}
		else {
			if(date > 60) --date;
			/* 1 = Jan 1 1900 */
			var d = new Date(1900,0,1);
			d.setDate(d.getDate() + date - 1);
			dout = [d.getFullYear(), d.getMonth()+1,d.getDate()];
			dow = d.getDay();
			if(date < 60) dow = (dow + 6) % 7;
			if(b2) dow = fix_hijri(d, dout);
		}
		out.y = dout[0]; out.m = dout[1]; out.d = dout[2];
		out.S = time % 60; time = Math.floor(time / 60);
		out.M = time % 60; time = Math.floor(time / 60);
		out.H = time;
		out.q = dow;
		return out;
	}
	
	function write_date(type, fmt, val, ss0) {
		var o="", ss=0, tt=0, y = val.y, out, outl = 0;
		switch(type) {
			case 98: /* 'b' buddhist year */
				y = val.y + 543;
				/* falls through */
			case 121: /* 'y' year */
			switch(fmt.length) {
				case 1: case 2: out = y % 100; outl = 2; break;
				default: out = y % 10000; outl = 4; break;
			} break;
			case 109: /* 'm' month */
			switch(fmt.length) {
				case 1: case 2: out = val.m; outl = fmt.length; break;
				case 3: return months[val.m-1][1];
				case 5: return months[val.m-1][0];
				default: return months[val.m-1][2];
			} break;
			case 100: /* 'd' day */
			switch(fmt.length) {
				case 1: case 2: out = val.d; outl = fmt.length; break;
				case 3: return days[val.q][0];
				default: return days[val.q][1];
			} break;
			case 104: /* 'h' 12-hour */
			switch(fmt.length) {
				case 1: case 2: out = 1+(val.H+11)%12; outl = fmt.length; break;
				default: throw 'bad hour format: ' + fmt;
			} break;
			case 72: /* 'H' 24-hour */
			switch(fmt.length) {
				case 1: case 2: out = val.H; outl = fmt.length; break;
				default: throw 'bad hour format: ' + fmt;
			} break;
			case 77: /* 'M' minutes */
			switch(fmt.length) {
				case 1: case 2: out = val.M; outl = fmt.length; break;
				default: throw 'bad minute format: ' + fmt;
			} break;
			case 115: /* 's' seconds */
			if(val.u === 0) switch(fmt) {
				case 's': case 'ss': return pad0(val.S, fmt.length);
				case '.0': case '.00': case '.000':
			}
			switch(fmt) {
				case 's': case 'ss': case '.0': case '.00': case '.000':
					if(ss0 >= 2) tt = ss0 === 3 ? 1000 : 100;
					else tt = ss0 === 1 ? 10 : 1;
					ss = Math.round((tt)*(val.S + val.u));
					if(ss >= 60*tt) ss = 0;
					if(fmt === 's') return ss === 0 ? "0" : ""+ss/tt;
					o = pad0(ss,2 + ss0);
					if(fmt === 'ss') return o.substr(0,2);
					return "." + o.substr(2,fmt.length-1);
				default: throw 'bad second format: ' + fmt;
			}
			case 90: /* 'Z' absolute time */
			switch(fmt) {
				case '[h]': case '[hh]': out = val.D*24+val.H; break;
				case '[m]': case '[mm]': out = (val.D*24+val.H)*60+val.M; break;
				case '[s]': case '[ss]': out = ((val.D*24+val.H)*60+val.M)*60+Math.round(val.S+val.u); break;
				default: throw 'bad abstime format: ' + fmt;
			} outl = fmt.length === 3 ? 1 : 2; break;
			case 101: /* 'e' era */
				out = y; outl = 1;
		}
		if(outl > 0) return pad0(out, outl); else return "";
	}
	
	function pad0(v,d){var t=""+v; return t.length>=d?t:fill('0',d-t.length)+t;}
	function fix_hijri(date, o) { return 0; }
	function fixopts(o){
		for(var y = 0; y != opts_fmt.length; ++y) if(o[opts_fmt[y][0]]===undefined) o[opts_fmt[y][0]]=opts_fmt[y][1];
	}
	
	var write_num = (function make_write_num(){
		var pct1 = /%/g;
		function write_num_pct(type, fmt, val){
			var sfmt = fmt.replace(pct1,""), mul = fmt.length - sfmt.length;
			return write_num(type, sfmt, val * Math.pow(10,2*mul)) + fill("%",mul);
		}
		function write_num_cm(type, fmt, val){
			var idx = fmt.length - 1;
			while(fmt.charCodeAt(idx-1) === 44) --idx;
			return write_num(type, fmt.substr(0,idx), val / Math.pow(10,3*(fmt.length-idx)));
		}
		function write_num_exp(fmt, val){
			var o;
			var idx = fmt.indexOf("E") - fmt.indexOf(".") - 1;
			if(fmt.match(/^#+0.0E\+0$/)) {
				var period = fmt.indexOf("."); if(period === -1) period=fmt.indexOf('E');
				var ee = Math.floor(Math.log(Math.abs(val))*Math.LOG10E)%period;
				if(ee < 0) ee += period;
				o = (val/Math.pow(10,ee)).toPrecision(idx+1+(period+ee)%period);
				if(o.indexOf("e") === -1) {
					var fakee = Math.floor(Math.log(Math.abs(val))*Math.LOG10E);
					if(o.indexOf(".") === -1) o = o[0] + "." + o.substr(1) + "E+" + (fakee - o.length+ee);
					else o += "E+" + (fakee - ee);
					while(o.substr(0,2) === "0.") {
						o = o[0] + o.substr(2,period) + "." + o.substr(2+period);
						o = o.replace(/^0+([1-9])/,"$1").replace(/^0+\./,"0.");
					}
					o = o.replace(/\+-/,"-");
				}
				o = o.replace(/^([+-]?)(\d*)\.(\d*)[Ee]/,function($$,$1,$2,$3) { return $1 + $2 + $3.substr(0,(period+ee)%period) + "." + $3.substr(ee) + "E"; });
			} else o = val.toExponential(idx);
			if(fmt.match(/E\+00$/) && o.match(/e[+-]\d$/)) o = o.substr(0,o.length-1) + "0" + o[o.length-1];
			if(fmt.match(/E\-/) && o.match(/e\+/)) o = o.replace(/e\+/,"e");
			return o.replace("e","E");
		}
		var frac1 = /# (\?+)( ?)\/( ?)(\d+)/;
		function write_num_f1(r, aval, sign) {
			var den = parseInt(r[4]), rr = Math.round(aval * den), base = Math.floor(rr/den);
			var myn = (rr - base*den), myd = den;
			return sign + (base === 0 ? "" : ""+base) + " " + (myn === 0 ? fill(" ", r[1].length + 1 + r[4].length) : pad_(myn,r[1].length) + r[2] + "/" + r[3] + pad0(myd,r[4].length));
		}
		function write_num_f2(r, aval, sign) {
			return sign + (aval === 0 ? "" : ""+aval) + fill(" ", r[1].length + 2 + r[4].length);
		}
		var dec1 = /^#*0*\.(0+)/;
		var closeparen = /\).*[0#]/;
		var phone = /\(###\) ###\\?-####/;
		function hashq(str) {
			var o = "", cc;
			for(var i = 0; i != str.length; ++i) switch((cc=str.charCodeAt(i))) {
				case 35: break;
				case 63: o+= " "; break;
				case 48: o+= "0"; break;
				default: o+= String.fromCharCode(cc);
			}
			return o;
		}
		function rnd(val, d) { var dd = Math.pow(10,d); return ""+(Math.round(val * dd)/dd); }
		function dec(val, d) { return Math.round((val-Math.floor(val))*Math.pow(10,d)); }
		function flr(val) { if(val < 2147483647 && val > -2147483648) return ""+(val >= 0 ? (val|0) : (val-1|0)); return ""+Math.floor(val); }
		function write_num_flt(type, fmt, val) {
			if(type.charCodeAt(0) === 40 && !fmt.match(closeparen)) {
				var ffmt = fmt.replace(/\( */,"").replace(/ \)/,"").replace(/\)/,"");
				if(val >= 0) return write_num_flt('n', ffmt, val);
				return '(' + write_num_flt('n', ffmt, -val) + ')';
			}
			if(fmt.charCodeAt(fmt.length - 1) === 44) return write_num_cm(type, fmt, val);
			if(fmt.indexOf('%') !== -1) return write_num_pct(type, fmt, val);
			if(fmt.indexOf('E') !== -1) return write_num_exp(fmt, val);
			if(fmt.charCodeAt(0) === 36) return "$"+write_num_flt(type,fmt.substr(fmt[1]==' '?2:1),val);
			var o, oo;
			var r, ri, ff, aval = Math.abs(val), sign = val < 0 ? "-" : "";
			if(fmt.match(/^00+$/)) return sign + pad0r(aval,fmt.length);
			if(fmt.match(/^[#?]+$/)) {
				o = pad0r(val,0); if(o === "0") o = "";
				return o.length > fmt.length ? o : hashq(fmt.substr(0,fmt.length-o.length)) + o;
			}
			if((r = fmt.match(frac1)) !== null) return write_num_f1(r, aval, sign);
			if(fmt.match(/^#+0+$/) !== null) return sign + pad0r(aval,fmt.length - fmt.indexOf("0"));
			if((r = fmt.match(dec1)) !== null) {
				o = rnd(val, r[1].length).replace(/^([^\.]+)$/,"$1."+r[1]).replace(/\.$/,"."+r[1]).replace(/\.(\d*)$/,function($$, $1) { return "." + $1 + fill("0", r[1].length-$1.length); });
				return fmt.indexOf("0.") !== -1 ? o : o.replace(/^0\./,".");
			}
			fmt = fmt.replace(/^#+([0.])/, "$1");
			if((r = fmt.match(/^(0*)\.(#*)$/)) !== null) {
				return sign + rnd(aval, r[2].length).replace(/\.(\d*[1-9])0*$/,".$1").replace(/^(-?\d*)$/,"$1.").replace(/^0\./,r[1].length?"0.":".");
			}
			if((r = fmt.match(/^#,##0(\.?)$/)) !== null) return sign + commaify(pad0r(aval,0));
			if((r = fmt.match(/^#,##0\.([#0]*0)$/)) !== null) {
				return val < 0 ? "-" + write_num_flt(type, fmt, -val) : commaify(""+(Math.floor(val))) + "." + pad0(dec(val, r[1].length),r[1].length);
			}
			if((r = fmt.match(/^#,#*,#0/)) !== null) return write_num_flt(type,fmt.replace(/^#,#*,/,""),val);
			if((r = fmt.match(/^([0#]+)(\\?-([0#]+))+$/)) !== null) {
				o = _strrev(write_num_flt(type, fmt.replace(/[\\-]/g,""), val));
				ri = 0;
				return _strrev(_strrev(fmt.replace(/\\/g,"")).replace(/[0#]/g,function(x){return ri<o.length?o[ri++]:x==='0'?'0':"";}));
			}
			if(fmt.match(phone) !== null) {
				o = write_num_flt(type, "##########", val);
				return "(" + o.substr(0,3) + ") " + o.substr(3, 3) + "-" + o.substr(6);
			}
			var oa = "";
			if((r = fmt.match(/^([#0?]+)( ?)\/( ?)([#0?]+)/)) !== null) {
				ri = Math.min(r[4].length,7);
				ff = frac(aval, Math.pow(10,ri)-1, false);
				o = "" + sign;
				oa = write_num("n", r[1], ff[1]);
				if(oa[oa.length-1] == " ") oa = oa.substr(0,oa.length-1) + "0";
				o += oa + r[2] + "/" + r[3];
				oa = rpad_(ff[2],ri);
				if(oa.length < r[4].length) oa = hashq(r[4].substr(r[4].length-oa.length)) + oa;
				o += oa;
				return o;
			}
			if((r = fmt.match(/^# ([#0?]+)( ?)\/( ?)([#0?]+)/)) !== null) {
				ri = Math.min(Math.max(r[1].length, r[4].length),7);
				ff = frac(aval, Math.pow(10,ri)-1, true);
				return sign + (ff[0]||(ff[1] ? "" : "0")) + " " + (ff[1] ? pad_(ff[1],ri) + r[2] + "/" + r[3] + rpad_(ff[2],ri): fill(" ", 2*ri+1 + r[2].length + r[3].length));
			}
			if((r = fmt.match(/^[#0?]+$/)) !== null) {
				o = pad0r(val, 0);
				if(fmt.length <= o.length) return o;
				return hashq(fmt.substr(0,fmt.length-o.length)) + o;
			}
		  if((r = fmt.match(/^([#0?]+)\.([#0]+)$/)) !== null) {
				o = "" + val.toFixed(Math.min(r[2].length,10)).replace(/([^0])0+$/,"$1");
				ri = o.indexOf(".");
				var lres = fmt.indexOf(".") - ri, rres = fmt.length - o.length - lres;
				return hashq(fmt.substr(0,lres) + o + fmt.substr(fmt.length-rres));
			}
			if((r = fmt.match(/^00,000\.([#0]*0)$/)) !== null) {
				ri = dec(val, r[1].length);
				return val < 0 ? "-" + write_num_flt(type, fmt, -val) : commaify(flr(val)).replace(/^\d,\d{3}$/,"0$&").replace(/^\d*$/,function($$) { return "00," + ($$.length < 3 ? pad0(0,3-$$.length) : "") + $$; }) + "." + pad0(ri,r[1].length);
			}
			switch(fmt) {
				case "#,###": var x = commaify(pad0r(aval,0)); return x !== "0" ? sign + x : "";
				default:
			}
			throw new Error("unsupported format |" + fmt + "|");
		}
		function write_num_cm2(type, fmt, val){
			var idx = fmt.length - 1;
			while(fmt.charCodeAt(idx-1) === 44) --idx;
			return write_num(type, fmt.substr(0,idx), val / Math.pow(10,3*(fmt.length-idx)));
		}
		function write_num_pct2(type, fmt, val){
			var sfmt = fmt.replace(pct1,""), mul = fmt.length - sfmt.length;
			return write_num(type, sfmt, val * Math.pow(10,2*mul)) + fill("%",mul);
		}
		function write_num_exp2(fmt, val){
			var o;
			var idx = fmt.indexOf("E") - fmt.indexOf(".") - 1;
			if(fmt.match(/^#+0.0E\+0$/)) {
				var period = fmt.indexOf("."); if(period === -1) period=fmt.indexOf('E');
				var ee = Math.floor(Math.log(Math.abs(val))*Math.LOG10E)%period;
				if(ee < 0) ee += period;
				o = (val/Math.pow(10,ee)).toPrecision(idx+1+(period+ee)%period);
				if(!o.match(/[Ee]/)) {
					var fakee = Math.floor(Math.log(Math.abs(val))*Math.LOG10E);
					if(o.indexOf(".") === -1) o = o[0] + "." + o.substr(1) + "E+" + (fakee - o.length+ee);
					else o += "E+" + (fakee - ee);
					o = o.replace(/\+-/,"-");
				}
				o = o.replace(/^([+-]?)(\d*)\.(\d*)[Ee]/,function($$,$1,$2,$3) { return $1 + $2 + $3.substr(0,(period+ee)%period) + "." + $3.substr(ee) + "E"; });
			} else o = val.toExponential(idx);
			if(fmt.match(/E\+00$/) && o.match(/e[+-]\d$/)) o = o.substr(0,o.length-1) + "0" + o[o.length-1];
			if(fmt.match(/E\-/) && o.match(/e\+/)) o = o.replace(/e\+/,"e");
			return o.replace("e","E");
		}
		function write_num_int(type, fmt, val) {
			if(type.charCodeAt(0) === 40 && !fmt.match(closeparen)) {
				var ffmt = fmt.replace(/\( */,"").replace(/ \)/,"").replace(/\)/,"");
				if(val >= 0) return write_num_int('n', ffmt, val);
				return '(' + write_num_int('n', ffmt, -val) + ')';
			}
			if(fmt.charCodeAt(fmt.length - 1) === 44) return write_num_cm2(type, fmt, val);
			if(fmt.indexOf('%') !== -1) return write_num_pct2(type, fmt, val);
			if(fmt.indexOf('E') !== -1) return write_num_exp2(fmt, val);
			if(fmt.charCodeAt(0) === 36) return "$"+write_num_int(type,fmt.substr(fmt[1]==' '?2:1),val);
			var o;
			var r, ri, ff, aval = Math.abs(val), sign = val < 0 ? "-" : "";
			if(fmt.match(/^00+$/)) return sign + pad0(aval,fmt.length);
			if(fmt.match(/^[#?]+$/)) {
				o = (""+val); if(val === 0) o = "";
				return o.length > fmt.length ? o : hashq(fmt.substr(0,fmt.length-o.length)) + o;
			}
			if((r = fmt.match(frac1)) !== null) return write_num_f2(r, aval, sign);
			if(fmt.match(/^#+0+$/) !== null) return sign + pad0(aval,fmt.length - fmt.indexOf("0"));
			if((r = fmt.match(dec1)) !== null) {
				o = (""+val).replace(/^([^\.]+)$/,"$1."+r[1]).replace(/\.$/,"."+r[1]).replace(/\.(\d*)$/,function($$, $1) { return "." + $1 + fill("0", r[1].length-$1.length); });
				return fmt.indexOf("0.") !== -1 ? o : o.replace(/^0\./,".");
			}
			fmt = fmt.replace(/^#+([0.])/, "$1");
			if((r = fmt.match(/^(0*)\.(#*)$/)) !== null) {
				return sign + (""+aval).replace(/\.(\d*[1-9])0*$/,".$1").replace(/^(-?\d*)$/,"$1.").replace(/^0\./,r[1].length?"0.":".");
			}
			if((r = fmt.match(/^#,##0(\.?)$/)) !== null) return sign + commaify((""+aval));
			if((r = fmt.match(/^#,##0\.([#0]*0)$/)) !== null) {
				return val < 0 ? "-" + write_num_int(type, fmt, -val) : commaify((""+val)) + "." + fill('0',r[1].length);
			}
			if((r = fmt.match(/^#,#*,#0/)) !== null) return write_num_int(type,fmt.replace(/^#,#*,/,""),val);
			if((r = fmt.match(/^([0#]+)(\\?-([0#]+))+$/)) !== null) {
				o = _strrev(write_num_int(type, fmt.replace(/[\\-]/g,""), val));
				ri = 0;
				return _strrev(_strrev(fmt.replace(/\\/g,"")).replace(/[0#]/g,function(x){return ri<o.length?o[ri++]:x==='0'?'0':"";}));
			}
			if(fmt.match(phone) !== null) {
				o = write_num_int(type, "##########", val);
				return "(" + o.substr(0,3) + ") " + o.substr(3, 3) + "-" + o.substr(6);
			}
			var oa = "";
			if((r = fmt.match(/^([#0?]+)( ?)\/( ?)([#0?]+)/)) !== null) {
				ri = Math.min(r[4].length,7);
				ff = frac(aval, Math.pow(10,ri)-1, false);
				o = "" + sign;
				oa = write_num("n", r[1], ff[1]);
				if(oa[oa.length-1] == " ") oa = oa.substr(0,oa.length-1) + "0";
				o += oa + r[2] + "/" + r[3];
				oa = rpad_(ff[2],ri);
				if(oa.length < r[4].length) oa = hashq(r[4].substr(r[4].length-oa.length)) + oa;
				o += oa;
				return o;
			}
			if((r = fmt.match(/^# ([#0?]+)( ?)\/( ?)([#0?]+)/)) !== null) {
				ri = Math.min(Math.max(r[1].length, r[4].length),7);
				ff = frac(aval, Math.pow(10,ri)-1, true);
				return sign + (ff[0]||(ff[1] ? "" : "0")) + " " + (ff[1] ? pad_(ff[1],ri) + r[2] + "/" + r[3] + rpad_(ff[2],ri): fill(" ", 2*ri+1 + r[2].length + r[3].length));
			}
			if((r = fmt.match(/^[#0?]+$/)) !== null) {
				o = "" + val;
				if(fmt.length <= o.length) return o;
				return hashq(fmt.substr(0,fmt.length-o.length)) + o;
			}
			if((r = fmt.match(/^([#0]+)\.([#0]+)$/)) !== null) {
				o = "" + val.toFixed(Math.min(r[2].length,10)).replace(/([^0])0+$/,"$1");
				ri = o.indexOf(".");
				var lres = fmt.indexOf(".") - ri, rres = fmt.length - o.length - lres;
				return hashq(fmt.substr(0,lres) + o + fmt.substr(fmt.length-rres));
			}
			if((r = fmt.match(/^00,000\.([#0]*0)$/)) !== null) {
				return val < 0 ? "-" + write_num_int(type, fmt, -val) : commaify(""+val).replace(/^\d,\d{3}$/,"0$&").replace(/^\d*$/,function($$) { return "00," + ($$.length < 3 ? pad0(0,3-$$.length) : "") + $$; }) + "." + pad0(0,r[1].length);
			}
			switch(fmt) {
				case "#,###": var x = commaify(""+aval); return x !== "0" ? sign + x : "";
				default:
			}
			throw new Error("unsupported format |" + fmt + "|");
		}
		return function write_num(type, fmt, val) {
			return (val|0) === val ? write_num_int(type, fmt, val) : write_num_flt(type, fmt, val);
		};})();
	
	return{
		DnPrepO_sheet_to_row_object_array : DnPrepO_sheet_to_row_object_array
	};
	
}());