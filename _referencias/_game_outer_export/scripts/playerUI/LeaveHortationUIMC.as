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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol502")]
   public dynamic class LeaveHortationUIMC extends MovieClip
   {
      
      public var txtOfflineTime:TextField;
      
      public var bar1xExp:IconBarMC;
      
      public var bar2xExp:IconBarMC;
      
      public var bar4xExp:IconBarMC;
      
      public var cmdExp2x:MainButton;
      
      public var cmdExp4x:MainButton;
      
      public var txt4xExp:TextField;
      
      public var txtDey2Bonus:TextField;
      
      public var txt2xExp:TextField;
      
      public var txtDey4Bonus:TextField;
      
      public var cmdInputBonusCode:MainButton;
      
      public var txt1xExp:TextField;
      
      public var txtDey4xPrompt:TextField;
      
      public var txtDey2xPrompt:TextField;
      
      public var txtDeyOfflineTime:TextField;
      
      public var cmdExp1x:MainButton;
      
      public var txtDey1xPrompt:TextField;
      
      public var txtDey1Bonus:TextField;
      
      public function LeaveHortationUIMC()
      {
         super();
         obf_H_u_2946();
         obf_u_h_2603();
         obf_f_D_2437();
         obf_e_z_2574();
      }
      
      internal function obf_e_z_2574() : *
      {
         try
         {
            cmdInputBonusCode["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdInputBonusCode.emphasized = false;
         cmdInputBonusCode.enabled = true;
         cmdInputBonusCode.label = "obf_____4725";
         cmdInputBonusCode.labelPlacement = "right";
         cmdInputBonusCode.selected = false;
         cmdInputBonusCode.toggle = false;
         cmdInputBonusCode.visible = true;
         try
         {
            cmdInputBonusCode["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_f_D_2437() : *
      {
         try
         {
            cmdExp4x["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdExp4x.emphasized = false;
         cmdExp4x.enabled = true;
         cmdExp4x.label = "obf___4957";
         cmdExp4x.labelPlacement = "right";
         cmdExp4x.selected = false;
         cmdExp4x.toggle = false;
         cmdExp4x.visible = true;
         try
         {
            cmdExp4x["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_u_h_2603() : *
      {
         try
         {
            cmdExp2x["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdExp2x.emphasized = false;
         cmdExp2x.enabled = true;
         cmdExp2x.label = "obf___4957";
         cmdExp2x.labelPlacement = "right";
         cmdExp2x.selected = false;
         cmdExp2x.toggle = false;
         cmdExp2x.visible = true;
         try
         {
            cmdExp2x["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_H_u_2946() : *
      {
         try
         {
            cmdExp1x["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdExp1x.emphasized = false;
         cmdExp1x.enabled = true;
         cmdExp1x.label = "obf___4957";
         cmdExp1x.labelPlacement = "right";
         cmdExp1x.selected = false;
         cmdExp1x.toggle = false;
         cmdExp1x.visible = true;
         try
         {
            cmdExp1x["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

