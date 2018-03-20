---
layout: post
title: Android 上使用 JSON
categories: [ dev, android ]
tags: [ json, gson ]
---

## Gson

* Gson - javadoc <https://www.javadoc.io/doc/com.google.code.gson/gson>

### Gson 解析 JSON

* <https://stackoverflow.com/a/5490987>

~~~
public String parse(String jsonLine) {
    JsonElement jelement = new JsonParser().parse(jsonLine);
    JsonObject  jobject = jelement.getAsJsonObject();
    jobject = jobject.getAsJsonObject("data");
    JsonArray jarray = jobject.getAsJsonArray("translations");
    jobject = jarray.get(0).getAsJsonObject();
    String result = jobject.get("translatedText").getAsString();
    return result;
}
~~~


## org.json

























































































