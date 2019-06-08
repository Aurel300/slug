import sys.io.File;

class Generate {
  static final CHARMAP_SOURCE_URL = "https://raw.githubusercontent.com/simov/slugify/master/charmap.json";
  static final CHARMAP_FILE = "charmap.json";
  
  public static function main():Void {
    if (Sys.args().indexOf("--update") != -1) {
      Sys.println("updating charmap ...");
      var proc = new sys.io.Process("curl", [CHARMAP_SOURCE_URL]);
      File.saveContent(CHARMAP_FILE, proc.stdout.readAll().toString());
      proc.close();
    }
    var data:Array<{key:String, value:String}> = haxe.Json.parse(File.getContent(CHARMAP_FILE));
    var template = new haxe.Template(File.getContent("Slug.template.hx"));
    File.saveContent("src/haxe/format/Slug.hx", "// This file is generated, do not edit directly.\n\n" + template.execute({charmap: [ for (d in data)
      '    ${d.key.charCodeAt(0)} => "${d.value}",'
    ].join("\n")}));
  }
}
