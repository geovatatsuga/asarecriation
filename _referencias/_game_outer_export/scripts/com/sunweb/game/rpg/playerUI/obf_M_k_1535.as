package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class obf_M_k_1535 extends Loader implements IPlayerUI
   {
      
      private var _url:String;
      
      private var _remoteUrlName:String;
      
      private var _urlLoader:URLLoader;
      
      public function obf_M_k_1535(param1:String)
      {
         super();
         this.onResize(null);
         this._urlLoader = new URLLoader();
         this._urlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onClose);
         this._urlLoader.addEventListener(Event.COMPLETE,this.obf_i_O_2744);
         this.contentLoaderInfo.addEventListener(Event.COMPLETE,this.obf_D_H_2364);
         this.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onClose);
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         this._remoteUrlName = param1;
         this._url = obf_C_o_3363.getUrl(this._remoteUrlName);
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
      }
      
      public function get url() : String
      {
         return this._url;
      }
      
      private function obf_s_6_1984() : void
      {
         this._url = obf_L_l_4100.obf_I_C_3435(this._url);
         if(obf_L_l_4100.isEmpty(this._url))
         {
            this.onClose(null);
            return;
         }
         if(this._url.substring(this._url.length - 4).toLowerCase() == ".swf")
         {
            this.load(new URLRequest(this._url));
         }
         else
         {
            this._urlLoader.load(new URLRequest(this._url));
         }
      }
      
      private function obf_i_O_2744(param1:Event) : void
      {
         this._url = this._urlLoader.data;
         this.obf_s_6_1984();
      }
      
      private function obf_D_H_2364(param1:Event) : void
      {
         if(this.content)
         {
            this.content.addEventListener("CloseThisFlash",this.onClose,true);
         }
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
      }
      
      public function showUI() : void
      {
         this.obf_s_6_1984();
      }
      
      public function closeUI() : void
      {
         this.destroy();
      }
      
      public function destroy() : void
      {
         if(this.content)
         {
            this.content.removeEventListener("CloseThisFlash",this.onClose);
         }
         this.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onClose);
         this.contentLoaderInfo.addEventListener(Event.COMPLETE,this.obf_D_H_2364);
         this._urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onClose);
         this._urlLoader.removeEventListener(Event.COMPLETE,this.obf_i_O_2744);
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         this.unload();
      }
   }
}

