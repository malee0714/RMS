package lims.util;

import javax.script.Invocable;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;

public class ScriptEngineUtil {
	public ScriptEngineManager manager = new ScriptEngineManager();
	public ScriptEngine engine = manager.getEngineByName("nashorn");
	public Invocable inv = null;
	
	/*
	 * function getEpsilon() {
	var e = 1.0;
	while ( ( 1.0 + 0.5 * e ) !== 1.0 )
	  e *= 0.5;
	return e;
}
	 * 
	 * */
	public ScriptEngineUtil() {
		String function 
		= "function getEpsilon() {"
				+ "var e = 1.0;"
				+ "while ( ( 1.0 + 0.5 * e ) !== 1.0 )"
				+ "e *= 0.5;"
				+ "return e;"
		+"}";
		
		
		try {
			engine.eval(function);
		} catch (Exception e) {
			throw new CustomException(e, "ScriptEngineUtil 생성자 error");
		}
	}
	
	public String epcilon() {
		inv = (Invocable) engine;
		
		try {
			return inv.invokeFunction("getEpsilon", null).toString();
		} catch (NoSuchMethodException e) {
			throw new CustomException(e, "NoSuchMethodExcpetion error");
		} catch (ScriptException e) {
			throw new CustomException(e, "ScriptException error");
		}
	}
	
	public String round(String nomfrmCn, String digit) {
		String result = "";
		try {
			result = engine.eval("Number("+nomfrmCn+").toFixed("+ digit +")").toString();
		} catch (ScriptException e) {
			e.printStackTrace();
			throw new CustomException(e, "ScriptEngineUtil round method error");
		}
		return result;
	}
}
