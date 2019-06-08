package haxe.format;

using StringTools;

class Slug {
  public static var charMap:Map<Int, String> = [
::charmap::
  ];
  
  public static final safe:EReg = ~/[^\w\s$*_+~.()'"!\-:@]/g;
  
  public static function encode(str:String, ?options:SlugOptions):String {
    if (options == null) options = {};
    var buf = new StringBuf();
    for (c in new haxe.iterators.StringIteratorUnicode(str))
      buf.add(charMap.exists(c) ? charMap[c] : String.fromCharCode(c));
    var ret = buf.toString().trim();
    ret = (options.remove != null ? options.remove : safe).map(ret, _ -> "");
    ret = ret.replace(" ", options.replacement);
    if (options.lower) return ret.toLowerCase();
    return ret;
  }
}

@:structInit class SlugOptions {
  public final lower:Bool = true;
  public final remove:EReg = null;
  public final replacement:String = "-";
}
