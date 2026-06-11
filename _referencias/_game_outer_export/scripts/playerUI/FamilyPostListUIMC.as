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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1546")]
   public dynamic class FamilyPostListUIMC extends MovieClip
   {
      
      public var cmdClose:SimpleButton;
      
      public var bgBox:MovieClip;
      
      public var cmdEdit:MainButton;
      
      public var txtDeyTitle:TextField;
      
      public var cmdSubmit:MainButton;
      
      public var listPost:MJList;
      
      public function FamilyPostListUIMC()
      {
         super();
         obf_z_j_3269();
         obf_D_m_1325();
      }
      
      internal function obf_z_j_3269() : *
      {
         try
         {
            cmdEdit["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdEdit.emphasized = false;
         cmdEdit.enabled = true;
         cmdEdit.label = "obf_______4300";
         cmdEdit.labelPlacement = "right";
         cmdEdit.selected = false;
         cmdEdit.toggle = false;
         cmdEdit.visible = true;
         try
         {
            cmdEdit["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_D_m_1325() : *
      {
         try
         {
            cmdSubmit["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdSubmit.emphasized = false;
         cmdSubmit.enabled = true;
         cmdSubmit.label = "obf_____4840";
         cmdSubmit.labelPlacement = "right";
         cmdSubmit.selected = false;
         cmdSubmit.toggle = false;
         cmdSubmit.visible = true;
         try
         {
            cmdSubmit["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

