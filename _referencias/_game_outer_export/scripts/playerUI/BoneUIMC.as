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
   import mcRes.AssembleLuckBox;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4075")]
   public dynamic class BoneUIMC extends MovieClip
   {
      
      public var txtPrompt:TextField;
      
      public var obf_Q_0_1896:AssembleLuckBox;
      
      public var txtCritDamage:TextField;
      
      public var txtL:TextField;
      
      public var material0:IconBarMC;
      
      public var txtPhysicalAttack:TextField;
      
      public var txtDeyCritDamage:TextField;
      
      public var txtDeyMagicDefense:TextField;
      
      public var levelPoint:MovieClip;
      
      public var btnList:MovieClip;
      
      public var cmdBone:SimpleButton;
      
      public var cmdRight:SimpleButton;
      
      public var txtDeyPhysicalAttack:TextField;
      
      public var txtDeyPierceAttack:TextField;
      
      public var txtDeyMagicAttack:TextField;
      
      public var cmdClean:SimpleButton;
      
      public var pointRefineIcon:MovieClip;
      
      public var pointRefineIcon1:MovieClip;
      
      public var pointRefineIcon2:MovieClip;
      
      public var txtPierceAttack:TextField;
      
      public var txtDeyPhysicalDefense:TextField;
      
      public var barBoneLevelPoint:MovieClip;
      
      public var txtMagicAttack:TextField;
      
      public var cmdRefine:SimpleButton;
      
      public var obf_O_A_4346:UIScrollBar;
      
      public var bgBox:MovieClip;
      
      public var titleBox:MovieClip;
      
      public var txtPhysicalDefense:TextField;
      
      public var txtDeyCritDefense:TextField;
      
      public var txtBoneLevelPoint:TextField;
      
      public var txtR:TextField;
      
      public var txtMagicDefense:TextField;
      
      public var txtChance:TextField;
      
      public var lv1:MovieClip;
      
      public var cmdLeft:SimpleButton;
      
      public var lv3:MovieClip;
      
      public var lv4:MovieClip;
      
      public var lv5:MovieClip;
      
      public var lv6:MovieClip;
      
      public var lv7:MovieClip;
      
      public var lv8:MovieClip;
      
      public var lv2:MovieClip;
      
      public var material1:IconBarMC;
      
      public var cmdClose:SimpleButton;
      
      public var equipBag1:IconBarMC;
      
      public var equipBag2:IconBarMC;
      
      public var txtCritDefense:TextField;
      
      public var showPhase:TextField;
      
      public var equipBag0:IconBarMC;
      
      public function BoneUIMC()
      {
         super();
         obf_H_p_1966();
      }
      
      internal function obf_H_p_1966() : *
      {
         try
         {
            obf_O_A_4346["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_O_A_4346.direction = "vertical";
         obf_O_A_4346.scrollTargetName = "txtPrompt";
         obf_O_A_4346.visible = true;
         try
         {
            obf_O_A_4346["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

