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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1532")]
   public dynamic class PlayerBookUIMC extends MovieClip
   {
      
      public var txtAttr:TextField;
      
      public var cmdAuto:MainButton;
      
      public var txtExp:TextField;
      
      public var skillBag0:SkillShowBoxUIMC;
      
      public var skillBag2:SkillShowBoxUIMC;
      
      public var skillBag3:SkillShowBoxUIMC;
      
      public var skillBag4:SkillShowBoxUIMC;
      
      public var skillBag5:SkillShowBoxUIMC;
      
      public var skillBag1:SkillShowBoxUIMC;
      
      public var txtName:TextField;
      
      public var bgBox2:MovieClip;
      
      public var picPoint:MovieClip;
      
      public var txtExpend:TextField;
      
      public var bgBox3:MovieClip;
      
      public var txtDeyTitle:TextField;
      
      public var expBar:MovieClip;
      
      public var bgBox:MovieClip;
      
      public var titleBox:MovieClip;
      
      public var txtAttrsName:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var txtBookSkill:TextField;
      
      public var picTips:MovieClip;
      
      public var txtBookStars:TextField;
      
      public var txtBookUp:TextField;
      
      public var cmdUp:MainButton;
      
      public var txtNum:TextField;
      
      public var txtAttrsValue:TextField;
      
      public function PlayerBookUIMC()
      {
         super();
         obf_u_z_4002();
         obf_0_1_f_289();
      }
      
      internal function obf_u_z_4002() : *
      {
         try
         {
            cmdUp["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdUp.emphasized = false;
         cmdUp.enabled = true;
         cmdUp.label = "obf___4917";
         cmdUp.labelPlacement = "right";
         cmdUp.selected = false;
         cmdUp.toggle = false;
         cmdUp.visible = true;
         try
         {
            cmdUp["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_1_f_289() : *
      {
         try
         {
            cmdAuto["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAuto.emphasized = false;
         cmdAuto.enabled = true;
         cmdAuto.label = "obf_____4739";
         cmdAuto.labelPlacement = "right";
         cmdAuto.selected = false;
         cmdAuto.toggle = false;
         cmdAuto.visible = true;
         try
         {
            cmdAuto["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

