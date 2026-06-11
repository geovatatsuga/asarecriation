package playerUI
{
   import ControlClass.MJCheckBox;
   import adobe.utils.*;
   import fl.controls.UIScrollBar;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1689")]
   public dynamic class AegisUIMC extends MovieClip
   {
      
      public var obf_0_2_q_196:UIScrollBar;
      
      public var InstanceName_0:MovieClip;
      
      public var cmdAegis:MainButton;
      
      public var card0:MovieClip;
      
      public var card1:MovieClip;
      
      public var card2:MovieClip;
      
      public var point3:MovieClip;
      
      public var point4:MovieClip;
      
      public var point5:MovieClip;
      
      public var card6:MovieClip;
      
      public var point7:MovieClip;
      
      public var point8:MovieClip;
      
      public var card3:MovieClip;
      
      public var explainScroll:UIScrollBar;
      
      public var card5:MovieClip;
      
      public var card7:MovieClip;
      
      public var point0:MovieClip;
      
      public var point1:MovieClip;
      
      public var cmdAegisLevel:MainButton;
      
      public var card4:MovieClip;
      
      public var point6:MovieClip;
      
      public var card8:MovieClip;
      
      public var obf_x_l_3067:TextField;
      
      public var point2:MovieClip;
      
      public var obf_0_8_B_611:MJCheckBox;
      
      public var txtSystem:TextField;
      
      public var addSpNumber:MovieClip;
      
      public var obf_b_0_808:IconBarMC;
      
      public var cmdClose:SimpleButton;
      
      public var AegisAtrr:TextField;
      
      public var bgBox:MovieClip;
      
      public var titleAegis:TextField;
      
      public function AegisUIMC()
      {
         super();
         obf_R_7_3593();
         obf_E_3_3215();
         obf_N_6_814();
         obf_b_1_3578();
         obf_0_7_A_313();
      }
      
      internal function obf_0_7_A_313() : *
      {
         try
         {
            obf_0_2_q_196["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_0_2_q_196.direction = "vertical";
         obf_0_2_q_196.scrollTargetName = "AegisAtrr";
         obf_0_2_q_196.visible = true;
         try
         {
            obf_0_2_q_196["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_R_7_3593() : *
      {
         try
         {
            cmdAegis["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAegis.emphasized = false;
         cmdAegis.enabled = true;
         cmdAegis.label = "obf___4974";
         cmdAegis.labelPlacement = "right";
         cmdAegis.selected = false;
         cmdAegis.toggle = false;
         cmdAegis.visible = true;
         try
         {
            cmdAegis["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_N_6_814() : *
      {
         try
         {
            obf_0_8_B_611["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_0_8_B_611.enabled = true;
         obf_0_8_B_611.label = "obf_______2887";
         obf_0_8_B_611.labelPlacement = "right";
         obf_0_8_B_611.selected = false;
         obf_0_8_B_611.visible = true;
         try
         {
            obf_0_8_B_611["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_E_3_3215() : *
      {
         try
         {
            cmdAegisLevel["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAegisLevel.emphasized = false;
         cmdAegisLevel.enabled = true;
         cmdAegisLevel.label = "obf_____4815";
         cmdAegisLevel.labelPlacement = "right";
         cmdAegisLevel.selected = false;
         cmdAegisLevel.toggle = false;
         cmdAegisLevel.visible = true;
         try
         {
            cmdAegisLevel["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_b_1_3578() : *
      {
         try
         {
            explainScroll["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         explainScroll.direction = "vertical";
         explainScroll.scrollTargetName = "txtSystem";
         explainScroll.visible = true;
         try
         {
            explainScroll["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

