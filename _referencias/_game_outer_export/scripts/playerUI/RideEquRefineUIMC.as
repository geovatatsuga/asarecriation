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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2013")]
   public dynamic class RideEquRefineUIMC extends MovieClip
   {
      
      public var txtAtt1:TextField;
      
      public var txtAtt2:TextField;
      
      public var cmdAttribute:TextField;
      
      public var changeAttribute:MainButton;
      
      public var choiceOrNot:MJCheckBox;
      
      public var txtAtt3:TextField;
      
      public var txtRefine1:TextField;
      
      public var txtRefine2:TextField;
      
      public var txtRefine3:TextField;
      
      public var refine:MainButton;
      
      public var txtDes1:TextField;
      
      public var txtDes2:TextField;
      
      public var txtDes3:TextField;
      
      public var cmdOk:MainButton;
      
      public var txtRefining1:TextField;
      
      public var txtRefining2:TextField;
      
      public var txtRefining3:TextField;
      
      public var equipImg:MovieClip;
      
      public function RideEquRefineUIMC()
      {
         super();
         obf_y_z_3717();
         obf_1_S_4062();
         obf_D_3_2122();
         obf_R_A_1900();
      }
      
      internal function obf_R_A_1900() : *
      {
         try
         {
            cmdOk["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdOk.emphasized = false;
         cmdOk.enabled = true;
         cmdOk.label = "obf___4891";
         cmdOk.labelPlacement = "right";
         cmdOk.selected = false;
         cmdOk.toggle = false;
         cmdOk.visible = true;
         try
         {
            cmdOk["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_y_z_3717() : *
      {
         try
         {
            changeAttribute["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         changeAttribute.emphasized = false;
         changeAttribute.enabled = true;
         changeAttribute.label = "obf_____4709";
         changeAttribute.labelPlacement = "right";
         changeAttribute.selected = false;
         changeAttribute.toggle = false;
         changeAttribute.visible = true;
         try
         {
            changeAttribute["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_D_3_2122() : *
      {
         try
         {
            refine["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         refine.emphasized = false;
         refine.enabled = true;
         refine.label = "obf___4965";
         refine.labelPlacement = "right";
         refine.selected = false;
         refine.toggle = false;
         refine.visible = true;
         try
         {
            refine["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_1_S_4062() : *
      {
         try
         {
            choiceOrNot["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         choiceOrNot.enabled = true;
         choiceOrNot.label = "Spend_%0_Crystal to 100% boost attributes.";
         choiceOrNot.labelPlacement = "right";
         choiceOrNot.selected = false;
         choiceOrNot.visible = true;
         try
         {
            choiceOrNot["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

