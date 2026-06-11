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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5192")]
   public dynamic class MasterBoxMC extends MovieClip
   {
      
      public var checkBox:MJCheckBox;
      
      public var txtExplain:TextField;
      
      public var cmdInvite:MainButton;
      
      public var headIconPoint:MovieClip;
      
      public var txtName:TextField;
      
      public var txtTimes:TextField;
      
      public function MasterBoxMC()
      {
         super();
         obf_Y_B_1147();
         obf_M_r_4510();
      }
      
      internal function obf_M_r_4510() : *
      {
         try
         {
            checkBox["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         checkBox.enabled = true;
         checkBox.label = "obf_______3178";
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
      
      internal function obf_Y_B_1147() : *
      {
         try
         {
            cmdInvite["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdInvite.emphasized = false;
         cmdInvite.enabled = true;
         cmdInvite.label = "obf___4971";
         cmdInvite.labelPlacement = "right";
         cmdInvite.selected = false;
         cmdInvite.toggle = false;
         cmdInvite.visible = true;
         try
         {
            cmdInvite["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

