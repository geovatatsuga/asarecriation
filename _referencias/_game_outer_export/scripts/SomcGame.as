package
{
   import ControlClass.MJCheckBox;
   import ControlClass.MJInput;
   import com.adobe.serialization.json.JSON;
   import com.sunweb.game.res.ResourceBag;
   import com.sunweb.game.res.ResourceLoaderContext;
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.res.obf_J_Y_3494;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.module.BackgroundModule;
   import com.sunweb.game.rpg.module.LoginModule;
   import com.sunweb.game.rpg.sound.obf_q_6_3634;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.ui.MouseCursor;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.obf_e_P_918;
   import com.sunweb.game.utils.obf_L_l_4100;
   import cursor.*;
   import fl.controls.ComboBox;
   import fl.controls.TextInput;
   import fl.controls.dataGridClasses.HeaderRenderer;
   import fl.controls.listClasses.CellRenderer;
   import fl.managers.StyleManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.text.TextFormat;
   import flash.utils.setTimeout;
   
   public class SomcGame extends Sprite
   {
      
      public function SomcGame()
      {
         super();
         this.hide3rdLogo();
         this.addEventListener(Event.ADDED_TO_STAGE,this.start);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.stop);
      }
      
      private function start(param1:Event) : void
      {
         this.initAll();
      }
      
      private function stop(param1:Event) : void
      {
      }
      
      private function hide3rdLogo() : void
      {
         var _loc1_:Bitmap = new Bitmap(new BitmapData(200,100,false,0));
         var _loc2_:Sprite = new Sprite();
         _loc2_.addChild(_loc1_);
         this.addChild(_loc2_);
      }
      
      private function initAll() : void
      {
         this.initStage();
         WindowManager.initialize(this);
         this.initMouse();
         this.initConfig();
      }
      
      private function initMouse() : void
      {
         obf_e_P_918.initialize(this.stage,new Sprite());
         obf_e_P_918.obf_k_D_2157(MouseCursor.CURSOR_UNMOVE,new CursorUnmove());
         obf_e_P_918.obf_k_D_2157(MouseCursor.CURSOR_ATTACK,new CursorAttack());
         obf_e_P_918.obf_k_D_2157(MouseCursor.CURSOR_FARM_REMOVE,new CursorFarmRemove());
         obf_e_P_918.obf_k_D_2157(MouseCursor.CURSOR_SELL,new CursorSell());
         obf_e_P_918.obf_k_D_2157(MouseCursor.CURSOR_DIALOG,new CursorDialog());
         obf_e_P_918.obf_k_D_2157(MouseCursor.CURSOR_USE,new CursorTargetToDo());
         obf_e_P_918.obf_k_D_2157(MouseCursor.obf_Y_t_2491,new CursorSplit());
         obf_e_P_918.obf_k_D_2157(MouseCursor.obf_0_n_4352,new CursorRepair());
      }
      
      private function initStyle() : void
      {
         var _loc1_:String = DiversityManager.getFontStyleName();
         var _loc2_:int = DiversityManager.getFontSize();
         StyleManager.setComponentStyle(MainButton,"textFormat",new TextFormat(_loc1_,_loc2_,16777215));
         StyleManager.setComponentStyle(MainButton,"disabledTextFormat",new TextFormat(_loc1_,_loc2_,10066329));
         StyleManager.setComponentStyle(MJCheckBox,"textFormat",new TextFormat(_loc1_,_loc2_,16777215));
         StyleManager.setComponentStyle(MJInput,"textFormat",new TextFormat(_loc1_,_loc2_,16777215));
         StyleManager.setComponentStyle(CellRenderer,"textFormat",new TextFormat(_loc1_,_loc2_,16777215));
         StyleManager.setComponentStyle(ComboBox,"textFormat",new TextFormat(_loc1_,_loc2_,16777215));
         StyleManager.setComponentStyle(TextInput,"textFormat",new TextFormat(_loc1_,_loc2_,16777215));
         StyleManager.setComponentStyle(HeaderRenderer,"textFormat",new TextFormat(_loc1_,_loc2_,16777215));
      }
      
      private function initStage() : void
      {
         this.stage.align = StageAlign.TOP_LEFT;
         this.stage.scaleMode = StageScaleMode.NO_SCALE;
         this.stage.frameRate = 32;
         this.stage.stageFocusRect = false;
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("rightClick",this.obf_z_V_3482);
         }
         try
         {
            ExternalInterface.call("onLogin");
         }
         catch(e:Error)
         {
         }
         GameContext.gameStage = this.stage;
         if(!ExternalInterface.available)
         {
            GameContext.gameStage.addEventListener(Event.DEACTIVATE,this.obf_C_h_2005);
         }
      }
      
      private function obf_C_h_2005(param1:Event) : void
      {
         trace("================ obf_____4791 ================");
         GameContext.gameStage.removeEventListener(Event.DEACTIVATE,this.obf_C_h_2005);
         GameContext.gameStage.addEventListener(Event.ACTIVATE,this.obf_T_G_2377);
         setTimeout(this.obf_a_J_2584,200);
      }
      
      private function obf_a_J_2584() : void
      {
         GameContext.gameStage.frameRate = 32;
      }
      
      private function obf_T_G_2377(param1:Event) : void
      {
         trace("================ obf_____4762 ================");
         GameContext.gameStage.removeEventListener(Event.ACTIVATE,this.obf_T_G_2377);
         GameContext.gameStage.addEventListener(Event.DEACTIVATE,this.obf_C_h_2005);
      }
      
      private function obf_z_V_3482() : void
      {
      }
      
      public function initConfig() : void
      {
         var _loc3_:String = null;
         var _loc1_:ResourceLoaderContext = ResourceLoaderContext.defaultContext;
         if(_loc1_ == null)
         {
            _loc3_ = obf_r_8_1121.getParameter(["host"]);
            if(obf_L_l_4100.isEmpty(_loc3_))
            {
               _loc3_ = this.loaderInfo.loaderURL;
               if(_loc3_.toLowerCase().indexOf("http://") == 0)
               {
                  _loc3_ = _loc3_.substr(0,_loc3_.indexOf("/",7));
               }
               else if(_loc3_.toLowerCase().indexOf("https://") == 0)
               {
                  _loc3_ = _loc3_.substr(0,_loc3_.indexOf("/",8));
               }
               else
               {
                  _loc3_ = "http://6.6.6.218";
               }
            }
            GameContext.resourceServerHttpHost = _loc3_;
         }
         else
         {
            GameContext.resourceServerHttpHost = _loc1_.httpServerURL;
         }
         GameContext.sso = obf_r_8_1121.getParameter(["sso"]);
         var _loc2_:URLLoader = new URLLoader();
         _loc2_.addEventListener(Event.COMPLETE,this.obf_0_1_2_259);
         _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.obf_b_b_1245);
         _loc2_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.obf_b_b_1245);
         _loc2_.dataFormat = URLLoaderDataFormat.BINARY;
         _loc2_.load(new URLRequest(GameContext.resourceServerHttpHost + "/res/data2?" + int(Math.random() * int.MAX_VALUE).toString(36)));
      }
      
      private function obf_0_1_2_259(param1:Event) : void
      {
         var _loc2_:Object = com.adobe.serialization.json.JSON.decode(ResourceManager.parseResourceText(param1.target.data));
         GameContext.loginServerIP = _loc2_.logHost;
         GameContext.loginServerPort = _loc2_.logPort;
         GameContext.policyServerPort = _loc2_.polPort;
         this.loadResourceList(GameContext.getFullResUrl(_loc2_.resUrl));
      }
      
      private function loadResourceList(param1:String) : void
      {
         var _loc2_:URLLoader = new URLLoader();
         _loc2_.addEventListener(Event.COMPLETE,this.obf_0_4_0_509);
         _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.obf_b_b_1245);
         _loc2_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.obf_b_b_1245);
         _loc2_.dataFormat = URLLoaderDataFormat.BINARY;
         _loc2_.load(new URLRequest(param1));
      }
      
      private function obf_b_b_1245(param1:Event) : void
      {
         trace("obf_______3692：" + param1.toString());
         WindowManager.showMessageBox("Resource Error!");
      }
      
      private function obf_0_4_0_509(param1:Event) : void
      {
         var _loc2_:ResourceLoaderContext = ResourceLoaderContext.defaultContext;
         if(_loc2_ == null)
         {
            if(ExternalInterface.available)
            {
               _loc2_ = new ResourceLoaderContext().setBrowserEnvironment(GameContext.resourceServerHttpHost);
            }
            else
            {
               _loc2_ = new ResourceLoaderContext().setAirEnvironment(GameContext.resourceServerHttpHost,obf_J_h_3675.loadLocalResource,obf_J_h_3675.saveLocalResource);
            }
         }
         ResourceManager.initializeInstance(ResourceManager.parseResourceText((param1.target as URLLoader).data),_loc2_);
         WorldConfig.initResList(ResourceManager.instance.resourceConfig.resGroups);
         var _loc3_:ResourceBag = ResourceManager.instance.getBag("diversityBag",true);
         _loc3_.loader.addEventListener(obf_J_Y_3494.COMPLETE,this.obf_0_5_J_700);
         _loc3_.obf_z_U_2156("idc");
         _loc3_.obf_z_U_2156("idv");
         _loc3_.obf_z_U_2156("imi");
         _loc3_.load();
      }
      
      private function obf_0_5_J_700(param1:Event) : void
      {
         DiversityManager.init(com.adobe.serialization.json.JSON.decode(ResourceManager.instance.getText("idc")));
         DiversityManager.addConfig(com.adobe.serialization.json.JSON.decode(ResourceManager.instance.getText("idv")));
         obf_q_6_3634.initMusicConfig(com.adobe.serialization.json.JSON.decode(ResourceManager.instance.getText("imi")));
         this.obf_0_9_R_121();
         this.startGame();
      }
      
      private function obf_0_9_R_121() : void
      {
         var _loc3_:String = null;
         var _loc1_:ResourceBag = ResourceManager.instance.getBag("commonInf",true);
         var _loc2_:Array = WorldConfig.getResList("res1");
         for each(_loc3_ in _loc2_)
         {
            _loc1_.obf_z_U_2156(_loc3_);
         }
         _loc1_.load();
      }
      
      private function startGame() : void
      {
         obf_q_6_3634.obf_T_T_4349.volume = 0.3;
         obf_q_6_3634.obf_w_z_1201("logoBG");
         this.initStyle();
         if(!GameContext.obf_A_E_1092())
         {
            WindowManager.showMessageBox(DiversityManager.getString("CommonPrompt","cantOpenMoreGame"),GameContext.ssoFailed);
            return;
         }
         WindowManager.showWindow(new BackgroundModule());
         WindowManager.showWindow(new LoginModule());
      }
   }
}

