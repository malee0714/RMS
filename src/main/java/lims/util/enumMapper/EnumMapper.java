package lims.util.enumMapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class EnumMapper {
    private Map<String, List<EnumValue>> factory = new HashMap<>();

    private List<EnumValue> toEnumValues(Class<? extends EnumModel> e){

        List<EnumValue> enumValues = new ArrayList<>();
        for (EnumModel enumType : e.getEnumConstants()) {
            enumValues.add(new EnumValue(enumType));
        }
        return enumValues;
    }

    public void put(String key, Class<? extends EnumModel> e){
        factory.put(key, toEnumValues(e));
    }

    public Map<String, List<EnumValue>> getAll(){
        return factory;
    }

    public Map<String, List<EnumValue>> get(String keys){

        Map<String, List<EnumValue>> result = new LinkedHashMap<>();
        for (String key : keys.split(",")) {
            result.put(key, factory.get(key));
        }

        return result;
    }
}