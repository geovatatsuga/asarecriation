package
{
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Endian;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   import loading.LoadingMC;
   
   public dynamic class WebLaucher extends Sprite
   {
      
      private var bitmaskTable:* = [8388608,4194304,2097152,1048576,524288,262144,131072,65536,32768,16384,8192,4096,2048,1024,512,256,128,64,32,16,8,4,2,1];
      
      private var encryptionKey1:String = "6bc89fe7d5a0f35f";
      
      private var loaderContext:* = createInstance(getDefinitionByName("flash.system.LoaderContext"));
      
      private var alignLeft:* = "left";
      
      private var xProperty:* = "x";
      
      private var yProperty:* = "y";
      
      private var dataProperty:* = "data";
      
      private var noScaleMode:* = "noScale";
      
      private var completeEvent:* = "complete";
      
      private var queryParamSymbol:* = "?";
      
      private var startGameLoad:* = "setupLoaderUI";
      
      private var gameBinaryLoader:*;
      
      private var dataLoader:*;
      
      private var encryptionKeyBytes:*;
      
      private var gameBinURL:* = "http://192.168.1.2/bin/game.bin";
      
      private var gameLoader:*;
      
      private var loadedBytes:*;
      
      private var methodIndexOf:* = "indexOf";
      
      private var textFieldInstance:* = createInstance(getDefinitionByName("flash.text.TextField"));
      
      private var autoSizeProperty:* = "autoSize";
      
      private var desKeySchedulePermutation:* = [13,16,10,23,0,4,2,27,14,5,20,9,22,18,11,3,25,7,15,6,26,19,12,1,40,51,30,36,46,54,29,39,50,44,32,47,43,48,38,55,33,52,45,41,49,35,28,31];
      
      private var desInitialPermutation:* = [56,48,40,32,24,16,8,0,57,49,41,33,25,17,9,1,58,50,42,34,26,18,10,2,59,51,43,35,62,54,46,38,30,22,14,6,61,53,45,37,29,21,13,5,60,52,44,36,28,20,12,4,27,19,11,3];
      
      private var methodCall:* = "call";
      
      private var loadingTextField:TextField;
      
      private var loadingMessage:* = "已加载: xx%，请稍候...";
      
      private var cryptoSeed1:uint = 34611;
      
      private var cryptoSeed2:uint = 4361;
      
      private var loadingMC:LoadingMC;
      
      private var externalInterfaceRef:* = getDefinitionByName("flash.external.ExternalInterface");
      
      private var loadedData:*;
      
      private var locationHrefGetter:* = "window.location.href.toString";
      
      private var replaceMethod:* = "replace";
      
      private var decryptionKeys:*;
      
      private var bitmaskTable8:* = [128,64,32,16,8,4,2,1];
      
      public var testEntryCount:int = 100000;
      
      private var md5Constants:* = [1,35,69,103,137,171,205,239,254,220,186,152,118,84,50,16,137,171,205,239,1,35,69,103];
      
      private var encryptionKeys:*;
      
      private var substrMethod:* = "substr";
      
      public var testEntriesDictionary:Dictionary;
      
      private var textColorProperty:* = "textColor";
      
      private var desSBox1:* = [16843776,0,65536,16843780,16842756,66564,4,65536,1024,16843776,16843780,1024,16778244,16842756,16777216,4,1028,16778240,16778240,66560,66560,16842752,16842752,16778244,65540,16777220,16777220,65540,0,1028,66564,16777216,65536,16843780,4,16842752,16843776,16777216,16777216,1024,16842756,65536,66560,16777220,1024,4,16778244,66564,16843780,65540,16842752,16778244,16777220,1028,66564,16843776,1028,16778240,16778240,0,65540,66560,0,16842756];
      
      private var desSBox2:* = [2148565024,2147516416,32768,1081376,1048576,32,2148532256,2147516448,2147483680,2148565024,2148564992,2147483648,2147516416,1048576,32,2148532256,1081344,1048608,2147516448,0,2147483648,32768,1081376,2148532224,1048608,2147483680,0,1081344,32800,2148564992,2148532224,32800,0,1081376,2148532256,1048576,2147516448,2148532224,2148564992,32768,2148532224,2147516416,32,2148565024,1081376,32,32768,2147483648,32800,2148564992,1048576,2147483680,1048608,2147516448,2147483680,1048608,1081344,0,2147516416,32800,2147483648,2148532256,2148565024,1081344];
      
      private var desSBox3:* = [8396801,8321,8321,128,8396928,8388737,8388609,8193,0,8396800,8396800,8396929,129,0,8388736,8388609,1,8192,8388608,8396801,128,8388608,8193,8320,8388737,1,8320,8388736,8192,8396928,8396929,129,8388736,8388609,8396800,8396929,129,0,0,8396800,8320,8388736,8388737,1,8396801,8321,8321,128,8396929,129,1,8192,8388609,8193,8396928,8388737,8193,8320,8388608,8396801,128,8388608,8192,8396928];
      
      private var desSBox4:* = [256,34078976,34078720,1107296512,524288,256,1073741824,34078720,1074266368,524288,33554688,1074266368,1107296512,1107820544,524544,1073741824,33554432,1074266112,1074266112,0,1073742080,1107820800,1107820800,33554688,1107820544,1073742080,0,1107296256,34078976,33554432,1107296256,524544,524288,1107296512,256,33554432,1073741824,34078720,1107296512,1074266368,33554688,1073741824,1107820544,34078976,1074266368,256,33554432,1107820544,1107820800,524544,1107296256,1107820800,34078720,0,1074266112,1107296256,524544,33554688,1073742080,524288,0,1074266112,34078976,1073742080];
      
      private var loadingMovieClip:* = createInstance(getDefinitionByName("loading.LoadingMC"));
      
      private var desSBox5:* = [268439616,4096,262144,268701760,268435456,268439616,64,268435456,262208,268697600,268701760,266240,268701696,266304,4096,64,268697600,268435520,268439552,4160,266240,262208,268697664,268701696,4160,0,0,268697664,268435520,268439552,266304,262144,266304,262144,268701696,4096,64,268697664,4096,266304,268439552,64,268435520,268697600,268697664,268435456,262144,268439616,0,268701760,262208,268435520,268697600,268439552,268439616,0,268701760,266240,266240,4160,4160,262208,268435456,268701696];
      
      private var stageReference:* = "stage";
      
      private var encryptionKey2:* = "2863cd82ab3dfe65";
      
      private var encryptionKey3:* = "32f9f4f750d2ad93";
      
      private var encryptionKey4:* = "234952a0d4a4f5da";
      
      private var encryptionKey5:* = "abad23058f345efe";
      
      private var encryptionKey6:* = "0e325f72a34b8502";
      
      private var encryptionKey7:* = "230a4573d29ff475";
      
      private var encryptionKey8:* = "9437ad50d3ad2f45";
      
      private var eventTargetProperty:* = "target";
      
      private var methodRemoveEventListener:* = "removeEventListener";
      
      private var desSBox6:* = [2097152,69206018,67110914,0,2048,67110914,2099202,69208064,69208066,2097152,0,67108866,2,67108864,69206018,2050,67110912,2099202,2097154,67110912,67108866,69206016,69208064,2097154,69206016,2048,2050,69208066,2099200,2,67108864,2099200,67108864,2099200,2097152,67110914,67110914,69206018,69206018,2,2097154,67108864,67110912,2097152,69208064,2050,2099202,69208064,2050,67108866,69208066,69206016,2099200,0,2,69208066,0,2099202,69206016,2048,67108866,67110912,2048,2097154];
      
      private var desSBox7:* = [520,134349312,0,134348808,134218240,0,131592,134218240,131080,134217736,134217736,131072,134349320,131080,134348800,520,134217728,8,134349312,512,131584,134348800,134348808,131592,134218248,131584,131072,134218248,8,134349320,512,134217728,134349312,134217728,131080,520,131072,134349312,134218240,0,512,131080,134349320,134218240,134217736,512,0,134348808,134218248,131072,134217728,134349320,8,131592,131584,134217736,134348800,134218248,520,134348800,131592,8,134348808,131584];
      
      private var desSBox8:* = [536870928,541065216,16384,541081616,541065216,16,541081616,4194304,536887296,4210704,4194304,536870928,4194320,536887296,536870912,16400,0,4194320,536887312,16384,4210688,536887312,16,541065232,541065232,0,4210704,541081600,16400,4210688,541081600,536870912,536887296,16,541065232,4210688,541081616,4194304,16400,536870928,4194304,536887296,536870912,16400,536870928,541081616,4210688,541065216,4210704,541081600,0,541065232,16,16384,541065216,4210704,16384,4194320,536887312,0,541081600,536870912,4194320,536887312];
      
      private var cryptoStateRegister:uint = 43839;
      
      private var desKeyShifts:* = [1,2,4,6,8,10,12,14,15,17,19,21,23,25,27,28];
      
      private var randomQueryString:* = int(Math.random() * int.MAX_VALUE).toString(36);
      
      public var benchmarkDictionary:Object;
      
      private var availabilityStatus:* = "available";
      
      public function WebLaucher()
      {
         super();
         cryptoStateRegister = (cryptoSeed1 >>> 4 ^ cryptoSeed2) & 0x0F0F0F0F;
         cryptoSeed2 ^= cryptoStateRegister;
         cryptoSeed1 ^= cryptoStateRegister << 4;
         cryptoStateRegister = (cryptoSeed1 >>> 16 ^ cryptoSeed2) & 0xFFFF;
         if(cryptoSeed1 != 0)
         {
            desFeistelLeft();
         }
         cryptoSeed2 ^= cryptoStateRegister;
         cryptoSeed1 ^= cryptoStateRegister << 16;
         cryptoStateRegister = (cryptoSeed2 >>> 2 ^ cryptoSeed1) & 0x33333333;
         cryptoSeed1 ^= cryptoStateRegister;
         cryptoSeed2 ^= cryptoStateRegister << 2;
         cryptoStateRegister = (cryptoSeed2 >>> 8 ^ cryptoSeed1) & 0xFF00FF;
         cryptoSeed1 ^= cryptoStateRegister;
         cryptoSeed2 ^= cryptoStateRegister << 8;
         cryptoSeed2 = (cryptoSeed2 << 1 | cryptoSeed2 >>> 31 & 1) & 0xFFFFFFFF;
         cryptoStateRegister = (cryptoSeed1 ^ cryptoSeed2) & 0xAAAAAAAA;
         if("align" != 0)
         {
            desFeistelRight();
         }
         cryptoSeed1 ^= cryptoStateRegister;
         cryptoSeed2 ^= cryptoStateRegister;
         cryptoSeed1 = (cryptoSeed1 << 1 | cryptoSeed1 >>> 31 & 1) & 0xFFFFFFFF;
         cryptoSeed2 = cryptoSeed2 << 31 | cryptoSeed2 >>> 1;
         cryptoStateRegister = (cryptoSeed1 ^ cryptoSeed2) & 0xAAAAAAAA;
         this["addEventListener"]("addedToStage",updateCryptoState);
         this["addEventListener"]("removedFromStage",onRemovedFromStage);
         cryptoSeed1 ^= cryptoStateRegister;
         cryptoSeed2 ^= cryptoStateRegister;
         cryptoSeed1 = cryptoSeed1 << 31 | cryptoSeed1 >>> 1;
         cryptoStateRegister = (cryptoSeed1 >>> 8 ^ cryptoSeed2) & 0xFF00FF;
         if(cryptoSeed2 != 0)
         {
            desSBoxLookup();
         }
         cryptoSeed2 ^= cryptoStateRegister;
         cryptoSeed1 ^= cryptoStateRegister << 8;
         cryptoStateRegister = (cryptoSeed1 >>> 2 ^ cryptoSeed2) & 0x33333333;
         cryptoSeed2 ^= cryptoStateRegister;
         cryptoSeed1 ^= cryptoStateRegister << 2;
         cryptoStateRegister = (cryptoSeed2 >>> 16 ^ cryptoSeed1) & 0xFFFF;
         if(cryptoSeed1 != 0)
         {
            desFeistelLeft();
         }
         cryptoSeed1 ^= cryptoStateRegister;
         cryptoSeed2 ^= cryptoStateRegister << 16;
         cryptoStateRegister = (cryptoSeed2 >>> 4 ^ cryptoSeed1) & 0x0F0F0F0F;
         cryptoSeed1 ^= cryptoStateRegister;
         cryptoSeed2 ^= cryptoStateRegister << 4;
      }
      
      private function clearEncryptionKeys() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < encryptionKeys.length)
         {
            encryptionKeys[_loc1_] = 0;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < decryptionKeys.length)
         {
            decryptionKeys[_loc1_] = 0;
            _loc1_++;
         }
         encryptionKeys = null;
         decryptionKeys = null;
      }
      
      private function desProcessBlock(param1:*, param2:*, param3:*, param4:*, param5:*) : void
      {
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         _loc8_ = uint((param2[param3 + 0] & 0xFF) << 24);
         _loc8_ = uint(_loc8_ | (param2[param3 + 1] & 0xFF) << 16);
         _loc8_ = uint(_loc8_ | (param2[param3 + 2] & 0xFF) << 8);
         _loc8_ = uint(_loc8_ | param2[param3 + 3] & 0xFF);
         _loc7_ = uint((param2[param3 + 4] & 0xFF) << 24);
         _loc7_ = uint(_loc7_ | (param2[param3 + 5] & 0xFF) << 16);
         _loc7_ = uint(_loc7_ | (param2[param3 + 6] & 0xFF) << 8);
         _loc7_ = uint(_loc7_ | param2[param3 + 7] & 0xFF);
         _loc6_ = uint((_loc8_ >>> 4 ^ _loc7_) & 0x0F0F0F0F);
         _loc7_ ^= _loc6_;
         _loc8_ ^= _loc6_ << 4;
         _loc6_ = uint((_loc8_ >>> 16 ^ _loc7_) & 0xFFFF);
         _loc7_ ^= _loc6_;
         _loc8_ ^= _loc6_ << 16;
         _loc6_ = uint((_loc7_ >>> 2 ^ _loc8_) & 0x33333333);
         _loc8_ ^= _loc6_;
         _loc7_ ^= _loc6_ << 2;
         _loc6_ = uint((_loc7_ >>> 8 ^ _loc8_) & 0xFF00FF);
         _loc8_ ^= _loc6_;
         _loc7_ ^= _loc6_ << 8;
         _loc7_ = uint((_loc7_ << 1 | _loc7_ >>> 31 & 1) & 0xFFFFFFFF);
         _loc6_ = uint((_loc8_ ^ _loc7_) & 0xAAAAAAAA);
         _loc8_ ^= _loc6_;
         _loc7_ ^= _loc6_;
         _loc8_ = uint((_loc8_ << 1 | _loc8_ >>> 31 & 1) & 0xFFFFFFFF);
         var _loc9_:uint = 0;
         while(_loc9_ < 8)
         {
            _loc6_ = uint(_loc7_ << 28 | _loc7_ >>> 4);
            _loc6_ = uint(_loc6_ ^ param1[_loc9_ * 4 + 0]);
            _loc10_ = uint(desSBox6[_loc6_ & 0x3F]);
            _loc10_ = uint(_loc10_ | desSBox4[_loc6_ >>> 8 & 0x3F]);
            _loc10_ = uint(_loc10_ | desSBox7[_loc6_ >>> 16 & 0x3F]);
            _loc10_ = uint(_loc10_ | desSBox1[_loc6_ >>> 24 & 0x3F]);
            _loc6_ = uint(_loc7_ ^ param1[_loc9_ * 4 + 1]);
            _loc10_ |= desSBox5[_loc6_ & 0x3F];
            _loc10_ = uint(_loc10_ | desSBox8[_loc6_ >>> 8 & 0x3F]);
            _loc10_ = uint(_loc10_ | desSBox3[_loc6_ >>> 16 & 0x3F]);
            _loc10_ = uint(_loc10_ | desSBox2[_loc6_ >>> 24 & 0x3F]);
            _loc8_ ^= _loc10_;
            _loc6_ = uint(_loc8_ << 28 | _loc8_ >>> 4);
            _loc6_ = uint(_loc6_ ^ param1[_loc9_ * 4 + 2]);
            _loc10_ = uint(desSBox6[_loc6_ & 0x3F]);
            _loc10_ = uint(_loc10_ | desSBox4[_loc6_ >>> 8 & 0x3F]);
            _loc10_ = uint(_loc10_ | desSBox7[_loc6_ >>> 16 & 0x3F]);
            _loc10_ = uint(_loc10_ | desSBox1[_loc6_ >>> 24 & 0x3F]);
            _loc6_ = uint(_loc8_ ^ param1[_loc9_ * 4 + 3]);
            _loc10_ |= desSBox5[_loc6_ & 0x3F];
            _loc10_ = uint(_loc10_ | desSBox8[_loc6_ >>> 8 & 0x3F]);
            _loc10_ = uint(_loc10_ | desSBox3[_loc6_ >>> 16 & 0x3F]);
            _loc10_ = uint(_loc10_ | desSBox2[_loc6_ >>> 24 & 0x3F]);
            _loc7_ ^= _loc10_;
            _loc9_++;
         }
         _loc7_ = uint(_loc7_ << 31 | _loc7_ >>> 1);
         _loc6_ = uint((_loc8_ ^ _loc7_) & 0xAAAAAAAA);
         _loc8_ ^= _loc6_;
         _loc7_ ^= _loc6_;
         _loc8_ = uint(_loc8_ << 31 | _loc8_ >>> 1);
         _loc6_ = uint((_loc8_ >>> 8 ^ _loc7_) & 0xFF00FF);
         _loc7_ ^= _loc6_;
         _loc8_ ^= _loc6_ << 8;
         _loc6_ = uint((_loc8_ >>> 2 ^ _loc7_) & 0x33333333);
         _loc7_ ^= _loc6_;
         _loc8_ ^= _loc6_ << 2;
         _loc6_ = uint((_loc7_ >>> 16 ^ _loc8_) & 0xFFFF);
         _loc8_ ^= _loc6_;
         _loc7_ ^= _loc6_ << 16;
         _loc6_ = uint((_loc7_ >>> 4 ^ _loc8_) & 0x0F0F0F0F);
         _loc8_ ^= _loc6_;
         _loc7_ ^= _loc6_ << 4;
         param4[param5 + 0] = _loc7_ >>> 24 & 0xFF;
         param4[param5 + 1] = _loc7_ >>> 16 & 0xFF;
         param4[param5 + 2] = _loc7_ >>> 8 & 0xFF;
         param4[param5 + 3] = _loc7_ & 0xFF;
         param4[param5 + 4] = _loc8_ >>> 24 & 0xFF;
         param4[param5 + 5] = _loc8_ >>> 16 & 0xFF;
         param4[param5 + 6] = _loc8_ >>> 8 & 0xFF;
         param4[param5 + 7] = _loc8_ & 0xFF;
      }
      
      private function onDataLoaded(param1:*) : void
      {
         var _loc2_:ByteArray = param1.target.data;
         var _loc3_:Loader = new Loader();
         this.addChild(_loc3_);
         _loc3_.loadBytes(_loc2_);
         trace("LOADING BYTES");
         trace(_loc2_.length);
      }
      
      public function iterateBenchmarkEntries() : void
      {
         var _loc2_:Entry = null;
         var _loc1_:int = getTimer();
         for each(_loc2_ in benchmarkDictionary)
         {
         }
      }
      
      private function § \x01\x01\x02\x0b§() : uint
      {
         return 64;
      }
      
      private function loadLogo() : *
      {
         var _loc1_:* = new Loader();
         _loc1_.x = this.stage.stageWidth / 2;
         _loc1_.y = this.stage.stageHeight / 2;
         this.addChild(_loc1_);
         _loc1_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,handleLogoError);
         _loc1_.load(new URLRequest("logo.swf"));
      }
      
      private function updateProgressText(param1:*) : void
      {
         loadingMovieClip["loadingText"]["text"] = "xx%"["replace"]("xx",(param1["bytesLoaded"] * "d"["charCodeAt"]() / param1["bytesTotal"])["toFixed"](1));
      }
      
      private function processDESBlock(param1:*, param2:uint = 0) : void
      {
         desProcessBlock(encryptionKeys,param1,param2,param1,param2);
      }
      
      private function handleLogoError(param1:Event) : void
      {
      }
      
      private function processConfigData(param1:*) : *
      {
         if(param1 == null || param1.length == 0)
         {
            return null;
         }
         if(param1[0] != 123)
         {
            initCryptoSystem(param1);
            param1["uncompress"]();
         }
         param1.position = 0;
         return param1["readUTFBytes"](param1["bytesAvailable"]);
      }
      
      private function processLoadedData(param1:*) : void
      {
         loadedData = param1["target"]["data"];
         var _loc2_:String = processConfigData(loadedData);
         if(_loc2_ != null)
         {
            gameBinURL = _loc2_["substring"](1,_loc2_["length"] - 1);
         }
         this[startGameLoad]();
      }
      
      private function hexToBytes(param1:*) : *
      {
         param1 = param1.replace(/\s|:/gm,"");
         var _loc2_:* = createInstance(getDefinitionByName("flash.utils.ByteArray"));
         if(param1.length & 1 == 1)
         {
            param1 = "0" + param1;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_[_loc3_ / 2] = parseInt(param1.substr(_loc3_,2),16);
            _loc3_ += 2;
         }
         return _loc2_;
      }
      
      public function benchmarktestEntriesDictionary() : void
      {
         var _loc3_:Entry = null;
         var _loc1_:int = getTimer();
         var _loc2_:int = 0;
         while(_loc2_ < testEntryCount)
         {
            _loc3_ = testEntriesDictionary["name" + _loc2_];
            _loc2_++;
         }
      }
      
      public function drawDebugOverlay() : void
      {
         this.graphics.lineStyle(1,16711680);
         this.graphics.drawRect(0,0,800,600);
         loadingTextField.multiline = true;
         loadingTextField.border = true;
         loadingTextField.borderColor = 16777215;
         loadingTextField.textColor = 16711680;
         this.addChild(loadingTextField);
         loadingTextField.htmlText = "<p align=\'center\'>第一行。。。。。。。。。。。。。。。。。。</p>";
         loadingTextField.htmlText = "<p align=\'center\'>第一行。。。。。。。。。。。。。。。。。。<br>第二行。。</p>";
      }
      
      private function desGenerateRoundKeys(param1:*, param2:*, param3:*) : *
      {
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc4_:Array = [];
         var _loc5_:* = createInstance(getDefinitionByName("flash.utils.ByteArray"));
         var _loc6_:* = createInstance(getDefinitionByName("flash.utils.ByteArray"));
         var _loc8_:uint = 0;
         while(_loc8_ < 56)
         {
            _loc7_ = uint(desInitialPermutation[_loc8_]);
            _loc5_[_loc8_] = (param2[param3 + (_loc7_ >>> 3)] & bitmaskTable8[_loc7_ & 7]) != 0;
            _loc8_++;
         }
         var _loc9_:uint = 0;
         while(_loc9_ < 16)
         {
            if(param1)
            {
               _loc10_ = uint(_loc9_ << 1);
            }
            else
            {
               _loc10_ = uint(15 - _loc9_ << 1);
            }
            _loc11_ = uint(_loc10_ + 1);
            _loc4_[_loc11_] = 0;
            _loc4_[_loc10_] = 0;
            _loc8_ = 0;
            while(_loc8_ < 28)
            {
               _loc7_ = _loc8_ + desKeyShifts[_loc9_];
               if(_loc7_ < 28)
               {
                  _loc6_[_loc8_] = _loc5_[_loc7_];
               }
               else
               {
                  _loc6_[_loc8_] = _loc5_[_loc7_ - 28];
               }
               _loc8_++;
            }
            _loc8_ = 28;
            while(_loc8_ < 56)
            {
               _loc7_ = _loc8_ + desKeyShifts[_loc9_];
               if(_loc7_ < 56)
               {
                  _loc6_[_loc8_] = _loc5_[_loc7_];
               }
               else
               {
                  _loc6_[_loc8_] = _loc5_[_loc7_ - 28];
               }
               _loc8_++;
            }
            _loc8_ = 0;
            while(_loc8_ < 24)
            {
               if(_loc6_[desKeySchedulePermutation[_loc8_]])
               {
                  _loc4_[_loc10_] |= bitmaskTable[_loc8_];
               }
               if(_loc6_[desKeySchedulePermutation[_loc8_ + 24]])
               {
                  _loc4_[_loc11_] |= bitmaskTable[_loc8_];
               }
               _loc8_++;
            }
            _loc9_++;
         }
         _loc9_ = 0;
         while(_loc9_ != 32)
         {
            _loc12_ = uint(_loc4_[_loc9_]);
            _loc13_ = uint(_loc4_[_loc9_ + 1]);
            _loc4_[_loc9_] = (_loc12_ & 0xFC0000) << 6 | (_loc12_ & 0x0FC0) << 10 | (_loc13_ & 0xFC0000) >>> 10 | (_loc13_ & 0x0FC0) >>> 6;
            _loc4_[_loc9_ + 1] = (_loc12_ & 0x03F000) << 12 | (_loc12_ & 0x3F) << 16 | (_loc13_ & 0x03F000) >>> 4 | _loc13_ & 0x3F;
            _loc9_ += 2;
         }
         return _loc4_;
      }
      
      private function onGameBinaryLoaded(param1:*) : void
      {
         cryptoStateRegister = (cryptoSeed1 >>> 4 ^ cryptoSeed2) & 0x0F0F0F0F;
         cryptoSeed2 ^= cryptoStateRegister;
         cryptoSeed1 ^= cryptoStateRegister << 4;
         cryptoStateRegister = (cryptoSeed1 >>> 16 ^ cryptoSeed2) & 0xFFFF;
         if(cryptoSeed1 > 0)
         {
            desFeistelLeft();
         }
         loadedBytes = param1["target"]["data"];
         if(cryptoSeed2 > 0)
         {
            desSBoxLookup();
         }
         cryptoSeed2 ^= cryptoStateRegister;
         cryptoSeed1 ^= cryptoStateRegister << 16;
         cryptoStateRegister = (cryptoSeed2 >>> 2 ^ cryptoSeed1) & 0x33333333;
         initCryptoSystem(loadedBytes);
         if(cryptoStateRegister > 0)
         {
            desFeistelRight();
         }
         cryptoSeed1 ^= cryptoStateRegister;
         cryptoSeed2 ^= cryptoStateRegister << 2;
         cryptoStateRegister = (cryptoSeed2 >>> 8 ^ cryptoSeed1) & 0xFF00FF;
         cryptoSeed1 ^= cryptoStateRegister;
         cryptoSeed2 ^= cryptoStateRegister << 8;
         cryptoSeed2 = (cryptoSeed2 << 1 | cryptoSeed2 >>> 31 & 1) & 0xFFFFFFFF;
         cryptoStateRegister = (cryptoSeed1 ^ cryptoSeed2) & 0xAAAAAAAA;
         loadedBytes["uncompress"]();
         gameLoader = createInstance(getDefinitionByName("flash.display.Loader"));
         this["stage"]["addChild"](gameLoader);
         cryptoSeed1 ^= cryptoStateRegister;
         cryptoSeed2 ^= cryptoStateRegister;
         cryptoSeed1 = (cryptoSeed1 << 1 | cryptoSeed1 >>> 31 & 1) & 0xFFFFFFFF;
         cryptoSeed2 = cryptoSeed2 << 31 | cryptoSeed2 >>> 1;
         cryptoStateRegister = (cryptoSeed1 ^ cryptoSeed2) & 0xAAAAAAAA;
         if(cryptoSeed1 == 0)
         {
            desFeistelLeft();
         }
         if(loaderContext["hasOwnProperty"]("allowLoadBytesCodeExecution"))
         {
            loaderContext["allowLoadBytesCodeExecution"] = true;
         }
         gameLoader["loadBytes"](loadedBytes,loaderContext);
         if(this["parent"] == this["stage"])
         {
            this["stage"]["removeChild"](this);
         }
         else
         {
            this["parent"]["parent"]["removeChild"](this["parent"]);
         }
         loadedBytes = null;
      }
      
      private function logLoaderParameters() : void
      {
         var _loc2_:String = null;
         var _loc1_:TextField = new TextField();
         _loc1_.autoSize = TextFieldAutoSize.LEFT;
         _loc1_.height = 100;
         _loc1_.appendText("---param---\n");
         for(_loc2_ in this.loaderInfo.parameters)
         {
            _loc1_.appendText(_loc2_ + ": " + this.loaderInfo.parameters[_loc2_] + "\n");
         }
         this.stage.addChild(_loc1_);
      }
      
      private function bytesToHex(param1:*, param2:Boolean = false) : *
      {
         var _loc3_:* = "";
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ += ("0" + param1[_loc4_].toString(16)).substr(-2,2);
            if(param2)
            {
               if(_loc4_ < param1.length - 1)
               {
                  _loc3_ += ":";
               }
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function handleLoadError(param1:*) : void
      {
         this[startGameLoad]();
      }
      
      public function onRemovedFromStage(param1:*) : void
      {
      }
      
      private function md5RoundF(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint) : uint
      {
         return md5RotateAdd(param2 & param3 | ~param2 & param4,param1,param2,param5,param6,param7);
      }
      
      private function md5RoundG(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint) : uint
      {
         return md5RotateAdd(param2 & param4 | param3 & ~param4,param1,param2,param5,param6,param7);
      }
      
      private function processMD5Block(param1:Array, param2:uint) : *
      {
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         param1[param2 >> 5] |= 128 << param2 % 32;
         param1[(param2 + 64 >>> 9 << 4) + 14] = param2;
         var _loc3_:uint = 1732584193;
         var _loc4_:uint = 4023233417;
         var _loc5_:uint = 2562383102;
         var _loc6_:uint = 271733878;
         var _loc7_:uint = 0;
         while(_loc7_ < param1.length)
         {
            param1[_loc7_] ||= 0;
            param1[_loc7_ + 1] ||= 0;
            param1[_loc7_ + 2] ||= 0;
            param1[_loc7_ + 3] ||= 0;
            param1[_loc7_ + 4] ||= 0;
            param1[_loc7_ + 5] ||= 0;
            param1[_loc7_ + 6] ||= 0;
            param1[_loc7_ + 7] ||= 0;
            param1[_loc7_ + 8] ||= 0;
            param1[_loc7_ + 9] ||= 0;
            param1[_loc7_ + 10] ||= 0;
            param1[_loc7_ + 11] ||= 0;
            param1[_loc7_ + 12] ||= 0;
            param1[_loc7_ + 13] ||= 0;
            param1[_loc7_ + 14] ||= 0;
            param1[_loc7_ + 15] ||= 0;
            _loc8_ = _loc3_;
            _loc9_ = _loc4_;
            _loc10_ = _loc5_;
            _loc11_ = _loc6_;
            _loc3_ = md5RoundF(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 0],7,3614090360);
            _loc6_ = md5RoundF(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 1],12,3905402710);
            _loc5_ = md5RoundF(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 2],17,606105819);
            _loc4_ = md5RoundF(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 3],22,3250441966);
            _loc3_ = md5RoundF(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 4],7,4118548399);
            _loc6_ = md5RoundF(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 5],12,1200080426);
            _loc5_ = md5RoundF(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 6],17,2821735955);
            _loc4_ = md5RoundF(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 7],22,4249261313);
            _loc3_ = md5RoundF(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 8],7,1770035416);
            _loc6_ = md5RoundF(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 9],12,2336552879);
            _loc5_ = md5RoundF(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 10],17,4294925233);
            _loc4_ = md5RoundF(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 11],22,2304563134);
            _loc3_ = md5RoundF(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 12],7,1804603682);
            _loc6_ = md5RoundF(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 13],12,4254626195);
            _loc5_ = md5RoundF(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 14],17,2792965006);
            _loc4_ = md5RoundF(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 15],22,1236535329);
            _loc3_ = md5RoundG(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 1],5,4129170786);
            _loc6_ = md5RoundG(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 6],9,3225465664);
            _loc5_ = md5RoundG(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 11],14,643717713);
            _loc4_ = md5RoundG(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 0],20,3921069994);
            _loc3_ = md5RoundG(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 5],5,3593408605);
            _loc6_ = md5RoundG(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 10],9,38016083);
            _loc5_ = md5RoundG(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 15],14,3634488961);
            _loc4_ = md5RoundG(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 4],20,3889429448);
            _loc3_ = md5RoundG(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 9],5,568446438);
            _loc6_ = md5RoundG(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 14],9,3275163606);
            _loc5_ = md5RoundG(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 3],14,4107603335);
            _loc4_ = md5RoundG(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 8],20,1163531501);
            _loc3_ = md5RoundG(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 13],5,2850285829);
            _loc6_ = md5RoundG(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 2],9,4243563512);
            _loc5_ = md5RoundG(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 7],14,1735328473);
            _loc4_ = md5RoundG(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 12],20,2368359562);
            _loc3_ = md5RoundH(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 5],4,4294588738);
            _loc6_ = md5RoundH(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 8],11,2272392833);
            _loc5_ = md5RoundH(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 11],16,1839030562);
            _loc4_ = md5RoundH(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 14],23,4259657740);
            _loc3_ = md5RoundH(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 1],4,2763975236);
            _loc6_ = md5RoundH(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 4],11,1272893353);
            _loc5_ = md5RoundH(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 7],16,4139469664);
            _loc4_ = md5RoundH(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 10],23,3200236656);
            _loc3_ = md5RoundH(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 13],4,681279174);
            _loc6_ = md5RoundH(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 0],11,3936430074);
            _loc5_ = md5RoundH(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 3],16,3572445317);
            _loc4_ = md5RoundH(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 6],23,76029189);
            _loc3_ = md5RoundH(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 9],4,3654602809);
            _loc6_ = md5RoundH(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 12],11,3873151461);
            _loc5_ = md5RoundH(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 15],16,530742520);
            _loc4_ = md5RoundH(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 2],23,3299628645);
            _loc3_ = md5RoundI(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 0],6,4096336452);
            _loc6_ = md5RoundI(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 7],10,1126891415);
            _loc5_ = md5RoundI(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 14],15,2878612391);
            _loc4_ = md5RoundI(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 5],21,4237533241);
            _loc3_ = md5RoundI(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 12],6,1700485571);
            _loc6_ = md5RoundI(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 3],10,2399980690);
            _loc5_ = md5RoundI(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 10],15,4293915773);
            _loc4_ = md5RoundI(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 1],21,2240044497);
            _loc3_ = md5RoundI(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 8],6,1873313359);
            _loc6_ = md5RoundI(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 15],10,4264355552);
            _loc5_ = md5RoundI(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 6],15,2734768916);
            _loc4_ = md5RoundI(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 13],21,1309151649);
            _loc3_ = md5RoundI(_loc3_,_loc4_,_loc5_,_loc6_,param1[_loc7_ + 4],6,4149444226);
            _loc6_ = md5RoundI(_loc6_,_loc3_,_loc4_,_loc5_,param1[_loc7_ + 11],10,3174756917);
            _loc5_ = md5RoundI(_loc5_,_loc6_,_loc3_,_loc4_,param1[_loc7_ + 2],15,718787259);
            _loc4_ = md5RoundI(_loc4_,_loc5_,_loc6_,_loc3_,param1[_loc7_ + 9],21,3951481745);
            _loc3_ += _loc8_;
            _loc4_ += _loc9_;
            _loc5_ += _loc10_;
            _loc6_ += _loc11_;
            _loc7_ += 16;
         }
         return [_loc3_,_loc4_,_loc5_,_loc6_];
      }
      
      private function md5RoundH(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint) : uint
      {
         return md5RotateAdd(param2 ^ param3 ^ param4,param1,param2,param5,param6,param7);
      }
      
      private function prepareMD5Input(param1:*) : *
      {
         var _loc2_:uint = param1.length * 8;
         var _loc3_:String = param1.endian;
         while(param1.length % 4 != 0)
         {
            param1[param1.length] = 0;
         }
         param1.position = 0;
         var _loc4_:Array = [];
         param1.endian = Endian.LITTLE_ENDIAN;
         var _loc5_:uint = 0;
         while(_loc5_ < param1.length)
         {
            _loc4_.push(param1.readUnsignedInt());
            _loc5_ += 4;
         }
         var _loc6_:Array = processMD5Block(_loc4_,_loc2_);
         var _loc7_:* = createInstance(getDefinitionByName("flash.utils.ByteArray"));
         _loc7_.endian = Endian.LITTLE_ENDIAN;
         _loc5_ = 0;
         while(_loc5_ < 4)
         {
            _loc7_.writeUnsignedInt(_loc6_[_loc5_]);
            _loc5_++;
         }
         param1.length = _loc2_ / 8;
         param1.endian = _loc3_;
         return _loc7_;
      }
      
      private function initializeEncryptionKeys(param1:*) : void
      {
         this.encryptionKeyBytes = param1;
         this.encryptionKeys = desGenerateRoundKeys(true,param1,0);
         this.decryptionKeys = desGenerateRoundKeys(false,param1,0);
      }
      
      private function md5RoundI(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint, param7:uint) : uint
      {
         return md5RotateAdd(param3 ^ (param2 | ~param4),param1,param2,param5,param6,param7);
      }
      
      private function createInstance(param1:*, param2:* = null) : *
      {
         return param2 == null ? new param1() : new param1(param2);
      }
      
      private function initCryptoSystem(param1:*) : void
      {
         if(!encryptionKeyBytes)
         {
            initializeEncryptionKeys(hexToBytes(encryptionKey1));
         }
         decryptDESBlock(param1);
      }
      
      private function desSBoxLookup() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc3_ ^= _loc1_;
         _loc2_ = _loc3_ << 28 | _loc3_ >>> 4;
         _loc1_ = desSBox6[_loc2_ & 0x3F];
         _loc1_ |= desSBox4[_loc2_ >>> 8 & 0x3F];
         _loc1_ |= desSBox7[_loc2_ >>> 16 & 0x3F];
         _loc1_ |= desSBox1[_loc2_ >>> 24 & 0x3F];
         _loc1_ |= desSBox5[_loc2_ & 0x3F];
         _loc1_ |= desSBox8[_loc2_ >>> 8 & 0x3F];
      }
      
      private function md5RotateAdd(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:uint) : uint
      {
         return rotateLeftAdd(param2 + param1 + param4 + param6,param5) + param3;
      }
      
      private function desFeistelRight() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         _loc2_ = _loc4_ << 28 | _loc4_ >>> 4;
         _loc1_ = desSBox6[_loc2_ & 0x3F];
         _loc1_ |= desSBox4[_loc2_ >>> 8 & 0x3F];
         _loc1_ |= desSBox7[_loc2_ >>> 16 & 0x3F];
         _loc1_ |= desSBox2[_loc2_ >>> 24 & 0x3F];
         _loc3_ ^= _loc1_;
         _loc2_ = _loc3_ << 28 | _loc3_ >>> 4;
         _loc1_ = desSBox6[_loc2_ & 0x3F];
         _loc1_ |= desSBox4[_loc2_ >>> 8 & 0x3F];
         _loc1_ |= desSBox5[_loc2_ & 0x3F];
         _loc1_ |= desSBox8[_loc2_ >>> 8 & 0x3F];
         _loc1_ |= desSBox2[_loc2_ >>> 24 & 0x3F];
         _loc4_ ^= _loc1_;
      }
      
      private function desFeistelLeft() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = undefined << 28 | undefined >>> 4;
         _loc1_ = desSBox6[_loc2_ & 0x3F];
         _loc1_ |= desSBox4[_loc2_ >>> 8 & 0x3F];
         _loc1_ |= desSBox7[_loc2_ >>> 16 & 0x3F];
         _loc1_ |= desSBox1[_loc2_ >>> 24 & 0x3F];
         _loc1_ |= desSBox5[_loc2_ & 0x3F];
         _loc1_ |= desSBox8[_loc2_ >>> 8 & 0x3F];
         _loc1_ |= desSBox3[_loc2_ >>> 16 & 0x3F];
         _loc1_ |= desSBox2[_loc2_ >>> 24 & 0x3F];
         _loc3_ ^= _loc1_;
      }
      
      private function desDecryptData(param1:*) : void
      {
         if(!encryptionKeyBytes)
         {
            initializeEncryptionKeys(hexToBytes(encryptionKey1));
         }
         processDESBlock(param1);
      }
      
      public function profileDictionaryReads() : void
      {
         var _loc2_:Entry = null;
         var _loc1_:int = getTimer();
         for each(var _loc3_ in testEntriesDictionary)
         {
            _loc2_ = _loc3_;
            _loc3_;
         }
      }
      
      private function getDesBlockSize() : uint
      {
         return 8;
      }
      
      private function generateMd5HexDigest(param1:*) : *
      {
         return bytesToHex(prepareMD5Input(param1));
      }
      
      public function updateCryptoState(param1:*) : void
      {
         this["loadLogo"]();
         cryptoStateRegister = (cryptoSeed1 >>> 4 ^ cryptoSeed2) & 0x0F0F0F0F;
         cryptoSeed2 ^= cryptoStateRegister;
         cryptoSeed1 ^= cryptoStateRegister << 4;
         cryptoStateRegister = (cryptoSeed1 >>> 16 ^ cryptoSeed2) & 0xFFFF;
         cryptoSeed2 = (cryptoSeed2 << 1 | cryptoSeed2 >>> 31 & 1) & 0xFFFFFFFF;
         cryptoStateRegister = (cryptoSeed1 ^ cryptoSeed2) & 0xAAAAAAAA;
         if("align" != 0)
         {
            desFeistelRight();
         }
         cryptoSeed1 ^= cryptoStateRegister;
         cryptoSeed2 ^= cryptoStateRegister;
         cryptoSeed1 = (cryptoSeed1 << 1 | cryptoSeed1 >>> 31 & 1) & 0xFFFFFFFF;
         cryptoSeed2 = cryptoSeed2 << 31 | cryptoSeed2 >>> 1;
         cryptoStateRegister = (cryptoSeed1 ^ cryptoSeed2) & 0xAAAAAAAA;
         this["startLoading"]();
         cryptoSeed1 ^= cryptoStateRegister;
         cryptoSeed2 ^= cryptoStateRegister;
         cryptoSeed1 = cryptoSeed1 << 31 | cryptoSeed1 >>> 1;
         cryptoStateRegister = (cryptoSeed1 >>> 8 ^ cryptoSeed2) & 0xFF00FF;
         if(cryptoSeed2 != 0)
         {
            desSBoxLookup();
         }
         cryptoSeed2 ^= cryptoStateRegister;
         cryptoSeed1 ^= cryptoStateRegister << 8;
         cryptoStateRegister = (cryptoSeed1 >>> 2 ^ cryptoSeed2) & 0x33333333;
         cryptoSeed2 ^= cryptoStateRegister;
         cryptoSeed1 ^= cryptoStateRegister << 2;
         cryptoStateRegister = (cryptoSeed2 >>> 16 ^ cryptoSeed1) & 0xFFFF;
         if(cryptoSeed1 != 0)
         {
            desFeistelLeft();
         }
         cryptoSeed1 ^= cryptoStateRegister;
         cryptoSeed2 ^= cryptoStateRegister << 16;
         cryptoStateRegister = (cryptoSeed2 >>> 4 ^ cryptoSeed1) & 0x0F0F0F0F;
         cryptoSeed1 ^= cryptoStateRegister;
         cryptoSeed2 ^= cryptoStateRegister << 4;
      }
      
      private function updateLoadingPercentage(param1:*) : void
      {
         loadingTextField.text = loadingMessage.replace("xx",(param1.bytesLoaded * 100 / param1.bytesTotal).toFixed(1));
      }
      
      public function createTestEntries() : void
      {
         var _loc3_:Entry = null;
         var _loc1_:int = getTimer();
         var _loc2_:int = 0;
         while(_loc2_ < testEntryCount)
         {
            _loc3_ = new Entry("name" + _loc2_,_loc2_);
            testEntriesDictionary[_loc3_.name] = _loc3_;
            _loc2_++;
         }
      }
      
      private function decryptDESBlock(param1:*, param2:uint = 0) : void
      {
         desProcessBlock(decryptionKeys,param1,param2,param1,param2);
      }
      
      private function noopErrorHandler(param1:*) : void
      {
      }
      
      private function getMd5BlockSize() : uint
      {
         return 16;
      }
      
      private function loadGameAssets(param1:String) : void
      {
         var _loc2_:URLRequest = new URLRequest(param1);
         var _loc3_:URLLoader = new URLLoader();
         _loc3_.dataFormat = URLLoaderDataFormat.BINARY;
         _loc3_.addEventListener(ProgressEvent.PROGRESS,updateLoadingPercentage);
         _loc3_.addEventListener(Event.COMPLETE,onDataLoaded);
         _loc3_.addEventListener(IOErrorEvent.IO_ERROR,logSecurityError);
         _loc3_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,logSecurityError);
         _loc3_.load(_loc2_);
      }
      
      private function logSecurityError(param1:*) : void
      {
         trace(param1.toString());
      }
      
      public function benchmarkDictionaryAccess() : void
      {
         var _loc3_:Entry = null;
         var _loc1_:int = getTimer();
         var _loc2_:int = 0;
         while(_loc2_ < testEntryCount)
         {
            _loc3_ = benchmarkDictionary["name" + _loc2_];
            _loc2_++;
         }
      }
      
      private function rotateLeftAdd(param1:uint, param2:uint) : uint
      {
         return param1 << param2 | param1 >>> 32 - param2;
      }
      
      public function populateTestEntries() : void
      {
         var _loc3_:Entry = null;
         var _loc1_:int = getTimer();
         var _loc2_:int = 0;
         while(_loc2_ < testEntryCount)
         {
            _loc3_ = new Entry("name" + _loc2_,_loc2_);
            benchmarkDictionary[_loc3_.name] = _loc3_;
            _loc2_++;
         }
      }
      
      private function startLoading() : void
      {
         var _loc2_:* = undefined;
         var _loc1_:* = this["loaderInfo"]["parameters"]["bin"];
         if(_loc1_)
         {
            gameBinURL = _loc1_;
            this[startGameLoad]();
         }
         else
         {
            _loc2_ = "/res/data1?" + randomQueryString;
            dataLoader = createInstance(getDefinitionByName("flash.net.URLLoader"));
            dataLoader["dataFormat"] = "binary";
            dataLoader["addEventListener"]("ioError",handleLoadError);
            dataLoader["addEventListener"]("securityError",handleLoadError);
            dataLoader["addEventListener"]("complete",processLoadedData);
            dataLoader["load"](createInstance(getDefinitionByName("flash.net.URLRequest"),_loc2_));
         }
      }
      
      private function setupLoaderUI() : void
      {
         cryptoStateRegister = (cryptoSeed1 >>> 4 ^ cryptoSeed2) & 0x0F0F0F0F;
         cryptoSeed2 ^= cryptoStateRegister;
         cryptoSeed1 ^= cryptoStateRegister << 4;
         cryptoStateRegister = (cryptoSeed1 >>> 16 ^ cryptoSeed2) & 0xFFFF;
         if(cryptoSeed1 > 0)
         {
            desFeistelLeft();
         }
         this["stage"]["align"] = "TL";
         this["stage"]["scaleMode"] = "noScale";
         if(cryptoSeed2 > 0)
         {
            desSBoxLookup();
         }
         cryptoSeed2 ^= cryptoStateRegister;
         cryptoSeed1 ^= cryptoStateRegister << 16;
         cryptoStateRegister = (cryptoSeed2 >>> 2 ^ cryptoSeed1) & 0x33333333;
         loadingMovieClip["x"] = this["stage"]["stageWidth"] * 0.5;
         loadingMovieClip["y"] = this["stage"]["stageHeight"] * 0.5 + 150;
         this["addChild"](loadingMovieClip);
         if(cryptoStateRegister > 0)
         {
            desFeistelRight();
         }
         cryptoSeed1 ^= cryptoStateRegister;
         cryptoSeed2 ^= cryptoStateRegister << 2;
         cryptoStateRegister = (cryptoSeed2 >>> 8 ^ cryptoSeed1) & 0xFF00FF;
         cryptoSeed1 ^= cryptoStateRegister;
         cryptoSeed2 ^= cryptoStateRegister << 8;
         cryptoSeed2 = (cryptoSeed2 << 1 | cryptoSeed2 >>> 31 & 1) & 0xFFFFFFFF;
         cryptoStateRegister = (cryptoSeed1 ^ cryptoSeed2) & 0xAAAAAAAA;
         gameBinaryLoader = createInstance(getDefinitionByName("flash.net.URLLoader"));
         gameBinaryLoader["dataFormat"] = "binary";
         gameBinaryLoader["addEventListener"]("progress",updateProgressText);
         gameBinaryLoader["addEventListener"]("ioError",noopErrorHandler);
         gameBinaryLoader["addEventListener"]("securityError",noopErrorHandler);
         gameBinaryLoader["addEventListener"]("complete",onGameBinaryLoaded);
         gameBinaryLoader["load"](createInstance(getDefinitionByName("flash.net.URLRequest"),gameBinURL));
         cryptoSeed1 ^= cryptoStateRegister;
         cryptoSeed2 ^= cryptoStateRegister;
         cryptoSeed1 = (cryptoSeed1 << 1 | cryptoSeed1 >>> 31 & 1) & 0xFFFFFFFF;
         cryptoSeed2 = cryptoSeed2 << 31 | cryptoSeed2 >>> 1;
         cryptoStateRegister = (cryptoSeed1 ^ cryptoSeed2) & 0xAAAAAAAA;
      }
   }
}

class Entry
{
   
   public var value:int;
   
   public var name:String;
   
   public function Entry(param1:String, param2:int)
   {
      super();
      name = param1;
      value = param2;
   }
}
