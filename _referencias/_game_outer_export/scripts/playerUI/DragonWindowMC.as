package playerUI
{
   import ControlClass.MJCheckBox;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol168")]
   public dynamic class DragonWindowMC extends MovieClip
   {
      
      public var checkBox:MJCheckBox;
      
      public var bg:MovieClip;
      
      public var cmdButton:MainButton;
      
      public var txtDeyTitle:TextField;
      
      public var titleBox:MovieClip;
      
      public var txtName:TextField;
      
      public var cmdClose:SimpleButton;
      
      public function DragonWindowMC()
      {
         super();
         obf_5_B_2844();
         obf_E_V_1188();
      }
      
      internal function obf_5_B_2844() : *
      {
         try
         {
            checkBox["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         checkBox.enabled = true;
         checkBox.label = "obf_____4792";
         checkBox.labelPlacement = "right";
         checkBox.selected = false;
         checkBox.visible = true;
         try
         {
            checkBox["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_E_V_1188() : *
      {
         try
         {
            cmdButton["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdButton.emphasized = false;
         cmdButton.enabled = true;
         cmdButton.label = "obf___4891";
         cmdButton.labelPlacement = "right";
         cmdButton.selected = false;
         cmdButton.toggle = false;
         cmdButton.visible = true;
         try
         {
            cmdButton["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

