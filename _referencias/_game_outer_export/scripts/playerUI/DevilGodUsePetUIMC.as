package playerUI
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2125")]
   public dynamic class DevilGodUsePetUIMC extends MovieClip
   {
      
      public var txtGrow:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var txtExplain2:TextField;
      
      public var bgBox:MovieClip;
      
      public var cmdSure:MainButton;
      
      public var txtExplain1:TextField;
      
      public var txtPower:TextField;
      
      public var petIcon:IconBarMC;
      
      public function DevilGodUsePetUIMC()
      {
         super();
         obf_Y_R_3277();
      }
      
      internal function obf_Y_R_3277() : *
      {
         try
         {
            cmdSure["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSure.emphasized = false;
         cmdSure.enabled = true;
         cmdSure.label = "obf___4864";
         cmdSure.labelPlacement = "right";
         cmdSure.selected = false;
         cmdSure.toggle = false;
         cmdSure.visible = true;
         try
         {
            cmdSure["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

