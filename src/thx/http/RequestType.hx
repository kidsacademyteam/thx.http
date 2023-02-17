package thx.http;

import haxe.io.Bytes;
import haxe.io.Input;

abstract RequestType(RequestTypeImpl) from RequestTypeImpl to RequestTypeImpl {
  @:from inline public static function fromString(s : String) : RequestType
    return Text(s);

  inline public static function fromStringWithEncoding(s : String, encoding : String) : RequestType
    return Text(s, encoding);

  @:from inline public static function fromBytes(b : Bytes) : RequestType
    return Binary(b);

  @:from inline public static function fromInput(i : Input) : RequestType
    return Input(i);
#if(nodejs || hxnodejs)
  @:from inline public static function fromJSBuffer(buffer : js.node.Buffer) : RequestType
    return JSBuffer(buffer);
#elseif js
  @:from inline public static function fromJSArrayBufferView(buffer : js.lib.ArrayBufferView) : RequestType
    return JSArrayBufferView(buffer);
  @:from inline public static function fromJSBlob(blob : js.html.Blob) : RequestType
    return JSBlob(blob);
  @:from inline public static function fromJSDocument(doc : js.html.HTMLDocument) : RequestType
    return JSDocument(doc);
  @:from inline public static function fromJSFormData(formData : js.html.FormData) : RequestType
    return JSFormData(formData);
#end


  public static var noBody(default, null) : RequestType = NoBody;
}

enum RequestTypeImpl {
  // TODO JSON
  NoBody;
  Text(s : String, ?encoding : String);
  Binary(b : Bytes);
  Input(s : Input);
#if(nodejs || hxnodejs)
  JSBuffer(buffer : js.node.Buffer);
  // TODO NodeJS pipes
#elseif js
  JSArrayBufferView(buffer : js.lib.ArrayBufferView);
  JSBlob(blob : js.html.Blob);
  JSDocument(doc : js.html.HTMLDocument);
  JSFormData(formData : js.html.FormData);
#end
}
