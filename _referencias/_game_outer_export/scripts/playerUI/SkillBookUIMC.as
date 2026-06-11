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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1206")]
   public dynamic class SkillBookUIMC extends MovieClip
   {
      
      public var obf_3_B_2905:UIScrollBar;
      
      public var skillTreeBG:MovieClip;
      
      public var skillBag0:IconBarMC;
      
      public var skillBag1:IconBarMC;
      
      public var skillBag2:IconBarMC;
      
      public var skillBag3:IconBarMC;
      
      public var skillBag4:IconBarMC;
      
      public var skillBag5:IconBarMC;
      
      public var skillBag6:IconBarMC;
      
      public var skillBag7:IconBarMC;
      
      public var skillBag8:IconBarMC;
      
      public var skillBag9:IconBarMC;
      
      public var txtDeyTitle:TextField;
      
      public var txtDeyDefaultSkill:TextField;
      
      public var jobSkill_0:MovieClip;
      
      public var jobSkill_1:MovieClip;
      
      public var jobSkill_2:MovieClip;
      
      public var jobSkill_3:MovieClip;
      
      public var txtDeyOtherSkill:TextField;
      
      public var jobSkill_5:MovieClip;
      
      public var jobSkill_6:MovieClip;
      
      public var bgBox:MovieClip;
      
      public var txtSkillPoint:TextField;
      
      public var jobSkill_4:MovieClip;
      
      public var titleBox:MovieClip;
      
      public var skillBag10:IconBarMC;
      
      public var skillBag11:IconBarMC;
      
      public var defaultSkillBag:IconBarMC;
      
      public var chkAutoCastSkill:MJCheckBox;
      
      public var cmdClose:SimpleButton;
      
      public var txtDeySkillPoint:TextField;
      
      public var pointTreePage:MovieClip;
      
      public function SkillBookUIMC()
      {
         super();
         obf_A_a_2630();
      }
      
      internal function obf_A_a_2630() : *
      {
         try
         {
            chkAutoCastSkill["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         chkAutoCastSkill.enabled = true;
         chkAutoCastSkill.label = "obf_______3890";
         chkAutoCastSkill.labelPlacement = "left";
         chkAutoCastSkill.selected = false;
         chkAutoCastSkill.visible = true;
         try
         {
            chkAutoCastSkill["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

