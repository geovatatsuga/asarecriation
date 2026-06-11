package playerUI
{
   import ControlClass.MJList;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1102")]
   public dynamic class RewardInfoBoxMC extends MovieClip
   {
      
      public var growBar:MovieClip;
      
      public var txtLv:TextField;
      
      public var badgeIconPoint:MovieClip;
      
      public var cmdOver:MainButton;
      
      public var txtInAllNum:TextField;
      
      public var obf_I_i_2086:IconBarMC;
      
      public var obf_k_8_3007:IconBarMC;
      
      public var txtAllExp:TextField;
      
      public var txtOver1:TextField;
      
      public var txtOver2:TextField;
      
      public var txtOver3:TextField;
      
      public var txtOver4:TextField;
      
      public var txtOver5:TextField;
      
      public var txtOverTitle:TextField;
      
      public var bgBox:MovieClip;
      
      public var txtAllInfo:TextField;
      
      public var cmdPlayerAward:MainButton;
      
      public var cmdGiveUp:MainButton;
      
      public var taskAwardContent:MovieClip;
      
      public var scrollTaskAward:UIScrollBar;
      
      public var txtExp:TextField;
      
      public var obf_k_1_1129:MovieClip;
      
      public var headIconPoint:MovieClip;
      
      public var cmdAddAllExp:MainButton;
      
      public var txtAllInfo1:TextField;
      
      public var InstanceName_0:MovieClip;
      
      public var txtInPlayerNum:TextField;
      
      public var txtRank:TextField;
      
      public var txtReward:TextField;
      
      public var txtAttrValue1:TextField;
      
      public var txtAttrValue2:TextField;
      
      public var taskList:MJList;
      
      public var cmdOver2:boxButton;
      
      public var cmdOver3:boxButton;
      
      public var cmdOver4:boxButton;
      
      public var cmdOver5:boxButton;
      
      public var txtAttrValue8:TextField;
      
      public var txtAttrValue3:TextField;
      
      public var txtAttrValue6:TextField;
      
      public var txtOutPlayerNum:TextField;
      
      public var txtAttr1:TextField;
      
      public var txtAttr2:TextField;
      
      public var txtAttr3:TextField;
      
      public var txtThisTask:TextField;
      
      public var txtAttr5:TextField;
      
      public var txtAttr6:TextField;
      
      public var txtAttr7:TextField;
      
      public var txtPlayerInfo:TextField;
      
      public var txtAttr4:TextField;
      
      public var cmdOver1:boxButton;
      
      public var growBarAllExp:MovieClip;
      
      public var txtAttrValue5:TextField;
      
      public var txtAttrValue7:TextField;
      
      public var scrollTaskDetail:UIScrollBar;
      
      public var txtAllAward:TextField;
      
      public var txtAward:TextField;
      
      public var txtAttrValue4:TextField;
      
      public var txtAttr8:TextField;
      
      public var txtTaskDetail:TextField;
      
      public var txtLevel:TextField;
      
      public var growBarExp:MovieClip;
      
      public function RewardInfoBoxMC()
      {
         super();
         obf_B_U_1431();
         obf_Y_e_2138();
      }
      
      internal function obf_Y_e_2138() : *
      {
         try
         {
            scrollTaskAward["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         scrollTaskAward.direction = "vertical";
         scrollTaskAward.scrollTargetName = "bgBox";
         scrollTaskAward.visible = true;
         try
         {
            scrollTaskAward["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_B_U_1431() : *
      {
         try
         {
            scrollTaskDetail["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         scrollTaskDetail.direction = "vertical";
         scrollTaskDetail.scrollTargetName = "InstanceName_1";
         scrollTaskDetail.visible = true;
         try
         {
            scrollTaskDetail["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

