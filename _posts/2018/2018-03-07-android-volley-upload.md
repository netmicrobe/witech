---
layout: post
title: android volley 上传文件
categories: [ dev, android ]
tags: [ http, networking, android, volley ]
---



* 参考
  * <https://www.simplifiedcoding.net/upload-image-to-server/#Volley-MultiPart-Request>
  * <https://my.oschina.net/u/1177694/blog/491834>
  * <https://gist.github.com/anggadarkprince/a7c536da091f4b26bb4abf2f92926594>


### 实现 multipart/form-data ，不借助第三方库

* VolleyMultipartRequest.java
  * CLASS VolleyMultipartRequest
  * CLASS VolleyMultipartRequest.DataPart

~~~ java
package net.simplifiedlearning.androiduploadimage;

import com.android.volley.AuthFailureError;
import com.android.volley.NetworkResponse;
import com.android.volley.ParseError;
import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.HttpHeaderParser;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Map;

/**
 * Created by Belal on 10/24/2017.
 */

public class VolleyMultipartRequest extends Request<NetworkResponse> {

  private final String twoHyphens = "--";
  private final String lineEnd = "\r\n";
  private final String boundary = "apiclient-" + System.currentTimeMillis();

  private Response.Listener<NetworkResponse> mListener;
  private Response.ErrorListener mErrorListener;
  private Map<String, String> mHeaders;


  public VolleyMultipartRequest(int method, String url,
                  Response.Listener<NetworkResponse> listener,
                  Response.ErrorListener errorListener) {
    super(method, url, errorListener);
    this.mListener = listener;
    this.mErrorListener = errorListener;
  }

  @Override
  public Map<String, String> getHeaders() throws AuthFailureError {
    return (mHeaders != null) ? mHeaders : super.getHeaders();
  }

  @Override
  public String getBodyContentType() {
    return "multipart/form-data;boundary=" + boundary;
  }

  @Override
  public byte[] getBody() throws AuthFailureError {
    ByteArrayOutputStream bos = new ByteArrayOutputStream();
    DataOutputStream dos = new DataOutputStream(bos);

    try {
      // populate text payload
      Map<String, String> params = getParams();
      if (params != null && params.size() > 0) {
        textParse(dos, params, getParamsEncoding());
      }

      // populate data byte payload
      Map<String, DataPart> data = getByteData();
      if (data != null && data.size() > 0) {
        dataParse(dos, data);
      }

      // close multipart form data after text and file data
      dos.writeBytes(twoHyphens + boundary + twoHyphens + lineEnd);

      return bos.toByteArray();
    } catch (IOException e) {
      e.printStackTrace();
    }
    return null;
  }

  /**
   * Custom method handle data payload.
   *
   * @return Map data part label with data byte
   * @throws AuthFailureError
   */
  protected Map<String, DataPart> getByteData() throws AuthFailureError {
    return null;
  }

  @Override
  protected Response<NetworkResponse> parseNetworkResponse(NetworkResponse response) {
    try {
      return Response.success(
          response,
          HttpHeaderParser.parseCacheHeaders(response));
    } catch (Exception e) {
      return Response.error(new ParseError(e));
    }
  }

  @Override
  protected void deliverResponse(NetworkResponse response) {
    mListener.onResponse(response);
  }

  @Override
  public void deliverError(VolleyError error) {
    mErrorListener.onErrorResponse(error);
  }

  /**
   * Parse string map into data output stream by key and value.
   *
   * @param dataOutputStream data output stream handle string parsing
   * @param params       string inputs collection
   * @param encoding     encode the inputs, default UTF-8
   * @throws IOException
   */
  private void textParse(DataOutputStream dataOutputStream, Map<String, String> params, String encoding) throws IOException {
    try {
      for (Map.Entry<String, String> entry : params.entrySet()) {
        buildTextPart(dataOutputStream, entry.getKey(), entry.getValue());
      }
    } catch (UnsupportedEncodingException uee) {
      throw new RuntimeException("Encoding not supported: " + encoding, uee);
    }
  }

  /**
   * Parse data into data output stream.
   *
   * @param dataOutputStream data output stream handle file attachment
   * @param data       loop through data
   * @throws IOException
   */
  private void dataParse(DataOutputStream dataOutputStream, Map<String, DataPart> data) throws IOException {
    for (Map.Entry<String, DataPart> entry : data.entrySet()) {
      buildDataPart(dataOutputStream, entry.getValue(), entry.getKey());
    }
  }

  /**
   * Write string data into header and data output stream.
   *
   * @param dataOutputStream data output stream handle string parsing
   * @param parameterName  name of input
   * @param parameterValue   value of input
   * @throws IOException
   */
  private void buildTextPart(DataOutputStream dataOutputStream, String parameterName, String parameterValue) throws IOException {
    dataOutputStream.writeBytes(twoHyphens + boundary + lineEnd);
    dataOutputStream.writeBytes("Content-Disposition: form-data; name=\"" + parameterName + "\"" + lineEnd);
    dataOutputStream.writeBytes(lineEnd);
    dataOutputStream.writeBytes(parameterValue + lineEnd);
  }

  /**
   * Write data file into header and data output stream.
   *
   * @param dataOutputStream data output stream handle data parsing
   * @param dataFile     data byte as DataPart from collection
   * @param inputName    name of data input
   * @throws IOException
   */
  private void buildDataPart(DataOutputStream dataOutputStream, DataPart dataFile, String inputName) throws IOException {
    dataOutputStream.writeBytes(twoHyphens + boundary + lineEnd);
    dataOutputStream.writeBytes("Content-Disposition: form-data; name=\"" +
        inputName + "\"; filename=\"" + dataFile.getFileName() + "\"" + lineEnd);
    if (dataFile.getType() != null && !dataFile.getType().trim().isEmpty()) {
      dataOutputStream.writeBytes("Content-Type: " + dataFile.getType() + lineEnd);
    }
    dataOutputStream.writeBytes(lineEnd);

    ByteArrayInputStream fileInputStream = new ByteArrayInputStream(dataFile.getContent());
    int bytesAvailable = fileInputStream.available();

    int maxBufferSize = 1024 * 1024;
    int bufferSize = Math.min(bytesAvailable, maxBufferSize);
    byte[] buffer = new byte[bufferSize];

    int bytesRead = fileInputStream.read(buffer, 0, bufferSize);

    while (bytesRead > 0) {
      dataOutputStream.write(buffer, 0, bufferSize);
      bytesAvailable = fileInputStream.available();
      bufferSize = Math.min(bytesAvailable, maxBufferSize);
      bytesRead = fileInputStream.read(buffer, 0, bufferSize);
    }

    dataOutputStream.writeBytes(lineEnd);
  }

  class DataPart {
    private String fileName;
    private byte[] content;
    private String type;

    public DataPart() {
    }

    DataPart(String name, byte[] data) {
      fileName = name;
      content = data;
    }

    String getFileName() {
      return fileName;
    }

    byte[] getContent() {
      return content;
    }

    String getType() {
      return type;
    }

  }
}
~~~

#### Upload Image to Server

~~~ java
package net.simplifiedlearning.androiduploadimage;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.provider.MediaStore;
import android.provider.Settings;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;

import com.android.volley.AuthFailureError;
import com.android.volley.NetworkResponse;
import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.Volley;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;


public class MainActivity extends AppCompatActivity {

  //ImageView to display image selected
  ImageView imageView;

  //edittext for getting the tags input
  EditText editTextTags;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);

    //initializing views
    imageView = (ImageView) findViewById(R.id.imageView);
    editTextTags = (EditText) findViewById(R.id.editTextTags);

    //checking the permission
    //if the permission is not given we will open setting to add permission
    //else app will not open
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M && ContextCompat.checkSelfPermission(this,
        Manifest.permission.READ_EXTERNAL_STORAGE)
        != PackageManager.PERMISSION_GRANTED) {
      Intent intent = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS,
          Uri.parse("package:" + getPackageName()));
      finish();
      startActivity(intent);
      return;
    }


    //adding click listener to button
    findViewById(R.id.buttonUploadImage).setOnClickListener(new View.OnClickListener() {
      @Override
      public void onClick(View view) {

        //if the tags edittext is empty
        //we will throw input error
        if (editTextTags.getText().toString().trim().isEmpty()) {
          editTextTags.setError("Enter tags first");
          editTextTags.requestFocus();
          return;
        }

        //if everything is ok we will open image chooser
        Intent i = new Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
        startActivityForResult(i, 100);
      }
    });
  }

  @Override
  protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    super.onActivityResult(requestCode, resultCode, data);
    if (requestCode == 100 && resultCode == RESULT_OK && data != null) {

      //getting the image Uri
      Uri imageUri = data.getData();
      try {
        //getting bitmap object from uri
        Bitmap bitmap = MediaStore.Images.Media.getBitmap(this.getContentResolver(), imageUri);

        //displaying selected image to imageview
        imageView.setImageBitmap(bitmap);

        //calling the method uploadBitmap to upload image
        uploadBitmap(bitmap);
      } catch (IOException e) {
        e.printStackTrace();
      }
    }
  }

  /*
  * The method is taking Bitmap as an argument
  * then it will return the byte[] array for the given bitmap
  * and we will send this array to the server
  * here we are using PNG Compression with 80% quality
  * you can give quality between 0 to 100
  * 0 means worse quality
  * 100 means best quality
  * */
  public byte[] getFileDataFromDrawable(Bitmap bitmap) {
    ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
    bitmap.compress(Bitmap.CompressFormat.PNG, 80, byteArrayOutputStream);
    return byteArrayOutputStream.toByteArray();
  }

  private void uploadBitmap(final Bitmap bitmap) {

    //getting the tag from the edittext
    final String tags = editTextTags.getText().toString().trim();

    //our custom volley request
    VolleyMultipartRequest volleyMultipartRequest = new VolleyMultipartRequest(Request.Method.POST, EndPoints.UPLOAD_URL,
        new Response.Listener<NetworkResponse>() {
          @Override
          public void onResponse(NetworkResponse response) {
            try {
              JSONObject obj = new JSONObject(new String(response.data));
              Toast.makeText(getApplicationContext(), obj.getString("message"), Toast.LENGTH_SHORT).show();
            } catch (JSONException e) {
              e.printStackTrace();
            }
          }
        },
        new Response.ErrorListener() {
          @Override
          public void onErrorResponse(VolleyError error) {
            Toast.makeText(getApplicationContext(), error.getMessage(), Toast.LENGTH_SHORT).show();
          }
        }) {

      /*
      * If you want to add more parameters with the image
      * you can do it here
      * here we have only one parameter with the image
      * which is tags
      * */
      @Override
      protected Map<String, String> getParams() throws AuthFailureError {
        Map<String, String> params = new HashMap<>();
        params.put("tags", tags);
        return params;
      }

      /*
      * Here we are passing image by renaming it with a unique name
      * */
      @Override
      protected Map<String, DataPart> getByteData() {
        Map<String, DataPart> params = new HashMap<>();
        long imagename = System.currentTimeMillis();
        params.put("pic", new DataPart(imagename + ".png", getFileDataFromDrawable(bitmap)));
        return params;
      }
    };

    //adding the request to volley
    Volley.newRequestQueue(this).add(volleyMultipartRequest);
  }
}
~~~






### 使用 Apache httpmime 库的方法


~~~ gradle
compile 'org.apache.httpcomponents:httpmime:4.5.5'
~~~

或者，下载 jar 包：
* apache download page >http://hc.apache.org/downloads.cgi>
* [httpmime-4.2.5.jar](http://download.csdn.net/download/chequer_lkp/8102751)

~~~ java
package com.android.volley.toolbox;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.entity.mime.content.StringBody;

import com.android.volley.AuthFailureError;
import com.android.volley.NetworkResponse;
import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyLog;
import com.common.utils.CLog;
import com.common.utils.FileUtil;

public class MultipartRequest extends Request<String> {

  private MultipartEntity entity = new MultipartEntity();

  private final Response.Listener<String> mListener;

  private List<File> mFileParts;
  private String mFilePartName;
  private Map<String, String> mParams;
  /**
   * 单个文件
   * @param url
   * @param errorListener
   * @param listener
   * @param filePartName
   * @param file
   * @param params
   */
  public MultipartRequest(String url, Response.ErrorListener errorListener,
      Response.Listener<String> listener, String filePartName, File file,
      Map<String, String> params) {
    super(Method.POST, url, errorListener);

    mFileParts = new ArrayList<File>();
    if (file != null) {
      mFileParts.add(file);
    }
    mFilePartName = filePartName;
    mListener = listener;
    mParams = params;
    buildMultipartEntity();
  }
  /**
   * 多个文件，对应一个key
   * @param url
   * @param errorListener
   * @param listener
   * @param filePartName
   * @param files
   * @param params
   */
  public MultipartRequest(String url, Response.ErrorListener errorListener,
      Response.Listener<String> listener, String filePartName,
      List<File> files, Map<String, String> params) {
    super(Method.POST, url, errorListener);
    mFilePartName = filePartName;
    mListener = listener;
    mFileParts = files;
    mParams = params;
    buildMultipartEntity();
  }

  private void buildMultipartEntity() {
    if (mFileParts != null && mFileParts.size() > 0) {
      for (File file : mFileParts) {
        entity.addPart(mFilePartName, new FileBody(file));
      }
      long l = entity.getContentLength();
      CLog.log(mFileParts.size()+"个，长度："+l);
    }

    try {
      if (mParams != null && mParams.size() > 0) {
        for (Map.Entry<String, String> entry : mParams.entrySet()) {
          entity.addPart(
              entry.getKey(),
              new StringBody(entry.getValue(), Charset
                  .forName("UTF-8")));
        }
      }
    } catch (UnsupportedEncodingException e) {
      VolleyLog.e("UnsupportedEncodingException");
    }
  }

  @Override
  public String getBodyContentType() {
    return entity.getContentType().getValue();
  }

  @Override
  public byte[] getBody() throws AuthFailureError {
    ByteArrayOutputStream bos = new ByteArrayOutputStream();
    try {
      entity.writeTo(bos);
    } catch (IOException e) {
      VolleyLog.e("IOException writing to ByteArrayOutputStream");
    }
    return bos.toByteArray();
  }

  @Override
  protected Response<String> parseNetworkResponse(NetworkResponse response) {
    CLog.log("parseNetworkResponse");
    if (VolleyLog.DEBUG) {
      if (response.headers != null) {
        for (Map.Entry<String, String> entry : response.headers
            .entrySet()) {
          VolleyLog.d(entry.getKey() + "=" + entry.getValue());
        }
      }
    }

    String parsed;
    try {
      parsed = new String(response.data,
          HttpHeaderParser.parseCharset(response.headers));
    } catch (UnsupportedEncodingException e) {
      parsed = new String(response.data);
    }
    return Response.success(parsed,
        HttpHeaderParser.parseCacheHeaders(response));
  }


  /*
   * (non-Javadoc)
   * 
   * @see com.android.volley.Request#getHeaders()
   */
  @Override
  public Map<String, String> getHeaders() throws AuthFailureError {
    VolleyLog.d("getHeaders");
    Map<String, String> headers = super.getHeaders();

    if (headers == null || headers.equals(Collections.emptyMap())) {
      headers = new HashMap<String, String>();
    }


    return headers;
  }

  @Override
  protected void deliverResponse(String response) {
    mListener.onResponse(response);
  }
}
~~~


### github - anggadarkprince 的方法

* come from : 
  * Upload file with Multipart Request Volley Android <https://gist.github.com/anggadarkprince/a7c536da091f4b26bb4abf2f92926594>

* AppHelper.java

~~~ java
import android.graphics.Bitmap;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import java.io.ByteArrayOutputStream;

/**
 * Sketch Project Studio
 * Created by Angga on 12/04/2016 14.27.
 */
public class AppHelper {  
  
  /**
   * Turn drawable resource into byte array.
   *
   * @param context parent context
   * @param id    drawable resource id
   * @return byte array
   */
  public static byte[] getFileDataFromDrawable(Context context, int id) {
    Drawable drawable = ContextCompat.getDrawable(context, id);
    Bitmap bitmap = ((BitmapDrawable) drawable).getBitmap();
    ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
    bitmap.compress(Bitmap.CompressFormat.PNG, 0, byteArrayOutputStream);
    return byteArrayOutputStream.toByteArray();
  }

  /**
   * Turn drawable into byte array.
   *
   * @param drawable data
   * @return byte array
   */
  public static byte[] getFileDataFromDrawable(Context context, Drawable drawable) {
    Bitmap bitmap = ((BitmapDrawable) drawable).getBitmap();
    ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
    bitmap.compress(Bitmap.CompressFormat.JPEG, 80, byteArrayOutputStream);
    return byteArrayOutputStream.toByteArray();
  }
}
~~~

* VolleyMultipartRequest.java

~~~ java
package com.sketchproject.infogue.modules;

import com.android.volley.AuthFailureError;
import com.android.volley.NetworkResponse;
import com.android.volley.ParseError;
import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.HttpHeaderParser;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Map;

/**
 * Custom request to make multipart header and upload file.
 * 
 * Sketch Project Studio
 * Created by Angga on 27/04/2016 12.05.
 */
public class VolleyMultipartRequest extends Request<NetworkResponse> {
  private final String twoHyphens = "--";
  private final String lineEnd = "\r\n";
  private final String boundary = "apiclient-" + System.currentTimeMillis();

  private Response.Listener<NetworkResponse> mListener;
  private Response.ErrorListener mErrorListener;
  private Map<String, String> mHeaders;

  /**
   * Default constructor with predefined header and post method.
   *
   * @param url       request destination
   * @param headers     predefined custom header
   * @param listener    on success achieved 200 code from request
   * @param errorListener on error http or library timeout
   */
  public VolleyMultipartRequest(String url, Map<String, String> headers,
                  Response.Listener<NetworkResponse> listener,
                  Response.ErrorListener errorListener) {
    super(Method.POST, url, errorListener);
    this.mListener = listener;
    this.mErrorListener = errorListener;
    this.mHeaders = headers;
  }

  /**
   * Constructor with option method and default header configuration.
   *
   * @param method    method for now accept POST and GET only
   * @param url       request destination
   * @param listener    on success event handler
   * @param errorListener on error event handler
   */
  public VolleyMultipartRequest(int method, String url,
                  Response.Listener<NetworkResponse> listener,
                  Response.ErrorListener errorListener) {
    super(method, url, errorListener);
    this.mListener = listener;
    this.mErrorListener = errorListener;
  }

  @Override
  public Map<String, String> getHeaders() throws AuthFailureError {
    return (mHeaders != null) ? mHeaders : super.getHeaders();
  }

  @Override
  public String getBodyContentType() {
    return "multipart/form-data;boundary=" + boundary;
  }

  @Override
  public byte[] getBody() throws AuthFailureError {
    ByteArrayOutputStream bos = new ByteArrayOutputStream();
    DataOutputStream dos = new DataOutputStream(bos);

    try {
      // populate text payload
      Map<String, String> params = getParams();
      if (params != null && params.size() > 0) {
        textParse(dos, params, getParamsEncoding());
      }

      // populate data byte payload
      Map<String, DataPart> data = getByteData();
      if (data != null && data.size() > 0) {
        dataParse(dos, data);
      }

      // close multipart form data after text and file data
      dos.writeBytes(twoHyphens + boundary + twoHyphens + lineEnd);

      return bos.toByteArray();
    } catch (IOException e) {
      e.printStackTrace();
    }
    return null;
  }

  /**
   * Custom method handle data payload.
   *
   * @return Map data part label with data byte
   * @throws AuthFailureError
   */
  protected Map<String, DataPart> getByteData() throws AuthFailureError {
    return null;
  }

  @Override
  protected Response<NetworkResponse> parseNetworkResponse(NetworkResponse response) {
    try {
      return Response.success(
          response,
          HttpHeaderParser.parseCacheHeaders(response));
    } catch (Exception e) {
      return Response.error(new ParseError(e));
    }
  }

  @Override
  protected void deliverResponse(NetworkResponse response) {
    mListener.onResponse(response);
  }

  @Override
  public void deliverError(VolleyError error) {
    mErrorListener.onErrorResponse(error);
  }

  /**
   * Parse string map into data output stream by key and value.
   *
   * @param dataOutputStream data output stream handle string parsing
   * @param params       string inputs collection
   * @param encoding     encode the inputs, default UTF-8
   * @throws IOException
   */
  private void textParse(DataOutputStream dataOutputStream, Map<String, String> params, String encoding) throws IOException {
    try {
      for (Map.Entry<String, String> entry : params.entrySet()) {
        buildTextPart(dataOutputStream, entry.getKey(), entry.getValue());
      }
    } catch (UnsupportedEncodingException uee) {
      throw new RuntimeException("Encoding not supported: " + encoding, uee);
    }
  }

  /**
   * Parse data into data output stream.
   *
   * @param dataOutputStream data output stream handle file attachment
   * @param data       loop through data
   * @throws IOException
   */
  private void dataParse(DataOutputStream dataOutputStream, Map<String, DataPart> data) throws IOException {
    for (Map.Entry<String, DataPart> entry : data.entrySet()) {
      buildDataPart(dataOutputStream, entry.getValue(), entry.getKey());
    }
  }

  /**
   * Write string data into header and data output stream.
   *
   * @param dataOutputStream data output stream handle string parsing
   * @param parameterName  name of input
   * @param parameterValue   value of input
   * @throws IOException
   */
  private void buildTextPart(DataOutputStream dataOutputStream, String parameterName, String parameterValue) throws IOException {
    dataOutputStream.writeBytes(twoHyphens + boundary + lineEnd);
    dataOutputStream.writeBytes("Content-Disposition: form-data; name=\"" + parameterName + "\"" + lineEnd);
    //dataOutputStream.writeBytes("Content-Type: text/plain; charset=UTF-8" + lineEnd);
    dataOutputStream.writeBytes(lineEnd);
    dataOutputStream.writeBytes(parameterValue + lineEnd);
  }

  /**
   * Write data file into header and data output stream.
   *
   * @param dataOutputStream data output stream handle data parsing
   * @param dataFile     data byte as DataPart from collection
   * @param inputName    name of data input
   * @throws IOException
   */
  private void buildDataPart(DataOutputStream dataOutputStream, DataPart dataFile, String inputName) throws IOException {
    dataOutputStream.writeBytes(twoHyphens + boundary + lineEnd);
    dataOutputStream.writeBytes("Content-Disposition: form-data; name=\"" +
        inputName + "\"; filename=\"" + dataFile.getFileName() + "\"" + lineEnd);
    if (dataFile.getType() != null && !dataFile.getType().trim().isEmpty()) {
      dataOutputStream.writeBytes("Content-Type: " + dataFile.getType() + lineEnd);
    }
    dataOutputStream.writeBytes(lineEnd);

    ByteArrayInputStream fileInputStream = new ByteArrayInputStream(dataFile.getContent());
    int bytesAvailable = fileInputStream.available();

    int maxBufferSize = 1024 * 1024;
    int bufferSize = Math.min(bytesAvailable, maxBufferSize);
    byte[] buffer = new byte[bufferSize];

    int bytesRead = fileInputStream.read(buffer, 0, bufferSize);

    while (bytesRead > 0) {
      dataOutputStream.write(buffer, 0, bufferSize);
      bytesAvailable = fileInputStream.available();
      bufferSize = Math.min(bytesAvailable, maxBufferSize);
      bytesRead = fileInputStream.read(buffer, 0, bufferSize);
    }

    dataOutputStream.writeBytes(lineEnd);
  }

  /**
   * Simple data container use for passing byte file
   */
  public class DataPart {
    private String fileName;
    private byte[] content;
    private String type;

    /**
     * Default data part
     */
    public DataPart() {
    }

    /**
     * Constructor with data.
     *
     * @param name label of data
     * @param data byte data
     */
    public DataPart(String name, byte[] data) {
      fileName = name;
      content = data;
    }

    /**
     * Constructor with mime data type.
     *
     * @param name   label of data
     * @param data   byte data
     * @param mimeType mime data like "image/jpeg"
     */
    public DataPart(String name, byte[] data, String mimeType) {
      fileName = name;
      content = data;
      type = mimeType;
    }

    /**
     * Getter file name.
     *
     * @return file name
     */
    public String getFileName() {
      return fileName;
    }

    /**
     * Setter file name.
     *
     * @param fileName string file name
     */
    public void setFileName(String fileName) {
      this.fileName = fileName;
    }

    /**
     * Getter content.
     *
     * @return byte file data
     */
    public byte[] getContent() {
      return content;
    }

    /**
     * Setter content.
     *
     * @param content byte file data
     */
    public void setContent(byte[] content) {
      this.content = content;
    }

    /**
     * Getter mime type.
     *
     * @return mime type
     */
    public String getType() {
      return type;
    }

    /**
     * Setter mime type.
     *
     * @param type mime type
     */
    public void setType(String type) {
      this.type = type;
    }
  }
}
~~~

* VolleySingleton.java

~~~ java
package com.sketchproject.infogue.modules;

import android.content.Context;
import android.graphics.Bitmap;
import android.support.v4.util.LruCache;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.toolbox.ImageLoader;
import com.android.volley.toolbox.Volley;

/**
 * Singleton volley to populate request into single queue.
 * 
 * Sketch Project Studio
 * Created by Angga on 22/04/2016 22.58.
 */
public class VolleySingleton {
  private static VolleySingleton mInstance;
  private RequestQueue mRequestQueue;
  private ImageLoader mImageLoader;
  private static Context mCtx;

  /**
   * Private constructor, only initialization from getInstance.
   *
   * @param context parent context
   */
  private VolleySingleton(Context context) {
    mCtx = context;
    mRequestQueue = getRequestQueue();

    mImageLoader = new ImageLoader(mRequestQueue,
        new ImageLoader.ImageCache() {
          private final LruCache<String, Bitmap> cache = new LruBitmapCache(mCtx);

          @Override
          public Bitmap getBitmap(String url) {
            return cache.get(url);
          }

          @Override
          public void putBitmap(String url, Bitmap bitmap) {
            cache.put(url, bitmap);
          }
        });
  }

  /**
   * Singleton construct design pattern.
   *
   * @param context parent context
   * @return single instance of VolleySingleton
   */
  public static synchronized VolleySingleton getInstance(Context context) {
    if (mInstance == null) {
      mInstance = new VolleySingleton(context);
    }
    return mInstance;
  }

  /**
   * Get current request queue.
   *
   * @return RequestQueue
   */
  public RequestQueue getRequestQueue() {
    if (mRequestQueue == null) {
      // getApplicationContext() is key, it keeps you from leaking the
      // Activity or BroadcastReceiver if someone passes one in.
      mRequestQueue = Volley.newRequestQueue(mCtx.getApplicationContext());
    }
    return mRequestQueue;
  }

  /**
   * Add new request depend on type like string, json object, json array request.
   *
   * @param req new request
   * @param <T> request type
   */
  public <T> void addToRequestQueue(Request<T> req) {
    getRequestQueue().add(req);
  }

  /**
   * Get image loader.
   *
   * @return ImageLoader
   */
  public ImageLoader getImageLoader() {
    return mImageLoader;
  }
}
~~~

* MainActivity.java

~~~ java
/**
 * Sketch Project Studio
 * Created by Angga 20/04/2016 19:32
 */
public class MainActivity extends AppCompatActivity {
  private EditText mNameInput;
  private EditText mLocationInput;
  private EditText mAboutInput;
  private EditText mContact;
  
  private ImageView mAvatarImage;
  private ImageView mCoverImage;
  
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);
    
    mNameInput = (EditText) findViewById(R.id.input_name);
    mLocationInput = (EditText) findViewById(R.id.input_location);
    mAboutInput = (EditText) findViewById(R.id.input_about);
    mContact = (EditText) findViewById(R.id.input_contact);
    
    mAvatarImage = (ImageView) findViewById(R.id.avatar);
    mCoverImage = (ImageView) findViewById(R.id.cover);
    
    // do anything before post data.. or triggered after button clicked
    saveProfileAccount();
  }
  
  private void saveProfileAccount() {
    // loading or check internet connection or something...
    // ... then
    String url = "http://www.angga-ari.com/api/something/awesome";
    VolleyMultipartRequest multipartRequest = new VolleyMultipartRequest(Request.Method.POST, url, new Response.Listener<NetworkResponse>() {
      @Override
      public void onResponse(NetworkResponse response) {
        String resultResponse = new String(response.data);
        try {
          JSONObject result = new JSONObject(resultResponse);
          String status = result.getString("status");
          String message = result.getString("message");

          if (status.equals(Constant.REQUEST_SUCCESS)) {
            // tell everybody you have succed upload image and post strings
            Log.i("Messsage", message);
          } else {
            Log.i("Unexpected", message);
          }
        } catch (JSONException e) {
          e.printStackTrace();
        }
      }
    }, new Response.ErrorListener() {
      @Override
      public void onErrorResponse(VolleyError error) {
        NetworkResponse networkResponse = error.networkResponse;
        String errorMessage = "Unknown error";
        if (networkResponse == null) {
          if (error.getClass().equals(TimeoutError.class)) {
            errorMessage = "Request timeout";
          } else if (error.getClass().equals(NoConnectionError.class)) {
            errorMessage = "Failed to connect server";
          }
        } else {
          String result = new String(networkResponse.data);
          try {
            JSONObject response = new JSONObject(result);
            String status = response.getString("status");
            String message = response.getString("message");
            
            Log.e("Error Status", status);
            Log.e("Error Message", message);

            if (networkResponse.statusCode == 404) {
              errorMessage = "Resource not found";
            } else if (networkResponse.statusCode == 401) {
              errorMessage = message+" Please login again";
            } else if (networkResponse.statusCode == 400) {
              errorMessage = message+ " Check your inputs";
            } else if (networkResponse.statusCode == 500) {
              errorMessage = message+" Something is getting wrong";
            }
          } catch (JSONException e) {
            e.printStackTrace();
          }
        }
        Log.i("Error", errorMessage);
        error.printStackTrace();
      }
    }) {
      @Override
      protected Map<String, String> getParams() {
        Map<String, String> params = new HashMap<>();
        params.put("api_token", "gh659gjhvdyudo973823tt9gvjf7i6ric75r76");
        params.put("name", mNameInput.getText().toString());
        params.put("location", mLocationInput.getText().toString());
        params.put("about", mAvatarInput.getText().toString());
        params.put("contact", mContactInput.getText().toString());
        return params;
      }

      @Override
      protected Map<String, DataPart> getByteData() {
        Map<String, DataPart> params = new HashMap<>();
        // file name could found file base or direct access from real path
        // for now just get bitmap data from ImageView
        params.put("avatar", new DataPart("file_avatar.jpg", AppHelper.getFileDataFromDrawable(getBaseContext(), mAvatarImage.getDrawable()), "image/jpeg"));
        params.put("cover", new DataPart("file_cover.jpg", AppHelper.getFileDataFromDrawable(getBaseContext(), mCoverImage.getDrawable()), "image/jpeg"));

        return params;
      }
    };

    VolleySingleton.getInstance(getBaseContext()).addToRequestQueue(multipartRequest);
  }
}
~~~



















































































