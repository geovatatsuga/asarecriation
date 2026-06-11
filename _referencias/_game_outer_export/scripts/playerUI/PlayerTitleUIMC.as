package playerUI
{
   import ControlClass.MJList;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3808")]
   public dynamic class PlayerTitleUIMC extends MovieClip
   {
      
      public var bgBox:MovieClip;
      
      public var txtDeyCurrentTitle:TextField;
      
      public var txtDeyCurrentKitTitle:TextField;
      
      public var listTitle:MJList;
      
      public var cmdClose:SimpleButton;
      
      public var titleBox:MovieClip;
      
      public var pointType:MovieClip;
      
      public var cmdUseTitle:MainButton;
      
      public var cmdUseKitTitle:MainButton;
      
      public var txtDeyTitle:TextField;
      
      public var txtCurrentKitTitle:TextField;
      
      public var txtCurrentTitle:TextField;
      
      public var txtTitleAttribute:TextField;
      
      public function PlayerTitleUIMC()
      {
         super();
         obf_0_2_i_122();
         obf_t_B_911();
      }
      
      internal function obf_t_B_911() : *
      {
         try
         {
            cmdUseKitTitle["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdUseKitTitle.emphasized = false;
         cmdUseKitTitle.enabled = true;
         cmdUseKitTitle.label = "obf_____4826";
         cmdUseKitTitle.labelPlacement = "right";
         cmdUseKitTitle.selected = false;
         cmdUseKitTitle.toggle = false;
         cmdUseKitTitle.visible = true;
         try
         {
            cmdUseKitTitle["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_2_i_122() : *
      {
         try
         {
            cmdUseTitle["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdUseTitle.emphasized = false;
         cmdUseTitle.enabled = true;
         cmdUseTitle.label = "obf_____4769";
         cmdUseTitle.labelPlacement = "right";
         cmdUseTitle.selected = false;
         cmdUseTitle.toggle = false;
         cmdUseTitle.visible = true;
         try
         {
            cmdUseTitle["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

