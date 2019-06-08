import haxe.format.Slug;

class Main {
  public static function main():Void {
    trace(Slug.encode("Čokoľvek $ %"));
    // output: cokolvek-dollar-percent
  }
}
