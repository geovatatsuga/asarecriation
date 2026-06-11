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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol787")]
   public dynamic class PlayerBlessUIMC extends MovieClip
   {
      
      public var bgBox:MovieClip;
      
      public var txtDeyPrompt:TextField;
      
      public var godTypeSkill_1:MovieClip;
      
      public var godTypeSkill_2:MovieClip;
      
      public var godTypeSkill_3:MovieClip;
      
      public var txtDeyGodLevel:TextField;
      
      public var titleBox:MovieClip;
      
      public var txtGodLevelName_1:TextField;
      
      public var txtGodLevelName_2:TextField;
      
      public var txtGodLevelName_3:TextField;
      
      public var txtDeyGodXP:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var cmdBless:MainButton;
      
      public var txtGodXP:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var obf_L_n_2312:MovieClip;
      
      public var txtGodLevel:TextField;
      
      public function PlayerBlessUIMC()
      {
         super();
         obf_f_X_1613();
      }
      
      internal function obf_f_X_1613() : *
      {
         try
         {
            cmdBless["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdBless.emphasized = false;
         cmdBless.enabled = true;
         cmdBless.label = "obf_____4812";
         cmdBless.labelPlacement = "right";
         cmdBless.selected = false;
         cmdBless.toggle = false;
         cmdBless.visible = true;
         try
         {
            cmdBless["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

