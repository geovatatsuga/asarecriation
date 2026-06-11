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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1074")]
   public dynamic class FateSkillUIMC extends MovieClip
   {
      
      public var txtTopFateSkill:TextField;
      
      public var txtNextFateSkill:TextField;
      
      public var txtDeyNeedPlayerLevel:TextField;
      
      public var txtNeedPlayerLevel:TextField;
      
      public var pointGold:MovieClip;
      
      public var txtDeyNextFateLevel:TextField;
      
      public var txtNeedExp:TextField;
      
      public var bag0:IconBarMC;
      
      public var bag1:IconBarMC;
      
      public var bag2:IconBarMC;
      
      public var bag3:IconBarMC;
      
      public var bag4:IconBarMC;
      
      public var m00:MovieClip;
      
      public var m01:MovieClip;
      
      public var m02:MovieClip;
      
      public var m03:MovieClip;
      
      public var m04:MovieClip;
      
      public var m05:MovieClip;
      
      public var m06:MovieClip;
      
      public var m07:MovieClip;
      
      public var txtNextFateLevel:TextField;
      
      public var txtDeyNeedItems:TextField;
      
      public var bgBox:MovieClip;
      
      public var txtDeyTopFateLevel:TextField;
      
      public var m10:MovieClip;
      
      public var m11:MovieClip;
      
      public var m12:MovieClip;
      
      public var m13:MovieClip;
      
      public var cmdUpFateSkill:MainButton;
      
      public var m15:MovieClip;
      
      public var titleBox:MovieClip;
      
      public var m14:MovieClip;
      
      public var m16:MovieClip;
      
      public var m20:MovieClip;
      
      public var m21:MovieClip;
      
      public var m22:MovieClip;
      
      public var m23:MovieClip;
      
      public var m24:MovieClip;
      
      public var m26:MovieClip;
      
      public var m27:MovieClip;
      
      public var txtCurrentFateSkill:TextField;
      
      public var m17:MovieClip;
      
      public var m25:MovieClip;
      
      public var obf_n_J_1794:MovieClip;
      
      public var m30:MovieClip;
      
      public var m31:MovieClip;
      
      public var m32:MovieClip;
      
      public var m33:MovieClip;
      
      public var m34:MovieClip;
      
      public var txtFateLevelPoint:TextField;
      
      public var m37:MovieClip;
      
      public var m36:MovieClip;
      
      public var m40:MovieClip;
      
      public var m41:MovieClip;
      
      public var m42:MovieClip;
      
      public var m43:MovieClip;
      
      public var obf_C_d_1907:UIScrollBar;
      
      public var m45:MovieClip;
      
      public var m46:MovieClip;
      
      public var m47:MovieClip;
      
      public var txtCurrentFateLevel:TextField;
      
      public var m44:MovieClip;
      
      public var txtDeyCurrentFateLevel:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var txtDeyNeedGold:TextField;
      
      public var txtNeedFateSkill:TextField;
      
      public var m50:MovieClip;
      
      public var m51:MovieClip;
      
      public var m52:MovieClip;
      
      public var m53:MovieClip;
      
      public var m54:MovieClip;
      
      public var m55:MovieClip;
      
      public var txtDeyNeedFateSkill:TextField;
      
      public var m35:MovieClip;
      
      public var cmdClose:SimpleButton;
      
      public var barFateLevelPoint:MovieClip;
      
      public var txtDeyNeedExp:TextField;
      
      public function FateSkillUIMC()
      {
         super();
         obf_m_U_1602();
         obf_0_9_1_320();
      }
      
      internal function obf_0_9_1_320() : *
      {
         try
         {
            obf_C_d_1907["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         obf_C_d_1907.direction = "vertical";
         obf_C_d_1907.scrollTargetName = "txtCurrentFateSkill";
         obf_C_d_1907.visible = true;
         try
         {
            obf_C_d_1907["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_m_U_1602() : *
      {
         try
         {
            cmdUpFateSkill["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdUpFateSkill.emphasized = false;
         cmdUpFateSkill.enabled = true;
         cmdUpFateSkill.label = "obf_____4810";
         cmdUpFateSkill.labelPlacement = "right";
         cmdUpFateSkill.selected = false;
         cmdUpFateSkill.toggle = false;
         cmdUpFateSkill.visible = true;
         try
         {
            cmdUpFateSkill["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

