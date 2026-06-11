package playerUI
{
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1309")]
   public dynamic class FavorUIMC extends MovieClip
   {
      
      public var iconItem1:IconBarMC;
      
      public var obf_H_w_3575:UIScrollBar;
      
      public var iconItem3:IconBarMC;
      
      public var iconItem2:IconBarMC;
      
      public var txtRemark:TextField;
      
      public var InstanceName_1:MovieClip;
      
      public var effectPoint2:MovieClip;
      
      public var effectPoint3:MovieClip;
      
      public var effectPoint4:MovieClip;
      
      public var effectPoint5:MovieClip;
      
      public var effectPoint1:MovieClip;
      
      public var cmdFavor:MainButton;
      
      public var obf_J_E_2279:UIScrollBar;
      
      public var bgBox:MovieClip;
      
      public var favorValue:TextField;
      
      public var txtFavorRemark:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var titleBox:MovieClip;
      
      public var txtFavorValue:TextField;
      
      public var lv1:MovieClip;
      
      public var lv2:MovieClip;
      
      public var lv3:MovieClip;
      
      public var lv4:MovieClip;
      
      public var num1:TextField;
      
      public var num2:TextField;
      
      public var num3:TextField;
      
      public var favorLv:MovieClip;
      
      public var lv5:MovieClip;
      
      public function FavorUIMC()
      {
         super();
         obf_m_i_1603();
         obf_x_o_2462();
         obf_w_k_2002();
      }
      
      internal function obf_w_k_2002() : *
      {
         try
         {
            obf_J_E_2279["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_J_E_2279.direction = "vertical";
         obf_J_E_2279.scrollTargetName = "txtRemark";
         obf_J_E_2279.visible = true;
         try
         {
            obf_J_E_2279["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_x_o_2462() : *
      {
         try
         {
            obf_H_w_3575["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_H_w_3575.direction = "vertical";
         obf_H_w_3575.scrollTargetName = "txtFavorRemark";
         obf_H_w_3575.visible = true;
         try
         {
            obf_H_w_3575["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_m_i_1603() : *
      {
         try
         {
            cmdFavor["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdFavor.emphasized = false;
         cmdFavor.enabled = true;
         cmdFavor.label = "obf___4881";
         cmdFavor.labelPlacement = "right";
         cmdFavor.selected = false;
         cmdFavor.toggle = false;
         cmdFavor.visible = true;
         try
         {
            cmdFavor["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

