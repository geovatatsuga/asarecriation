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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2358")]
   public dynamic class MonthCardUIMC extends MovieClip
   {
      
      public var txtCreditReamrk:TextField;
      
      public var cmdBuy1:MainButton;
      
      public var txtcreditValue:TextField;
      
      public var cmdBuy0:MainButton;
      
      public var txtRemark1:TextField;
      
      public var txtRemark2:TextField;
      
      public var timeTxt0:TextField;
      
      public var timeTxt1:TextField;
      
      public var cmdGet0:MainButton;
      
      public var cmdGet1:MainButton;
      
      public var titleTxt0:TextField;
      
      public var titleTxt1:TextField;
      
      public function MonthCardUIMC()
      {
         super();
         obf_n_s_3351();
         obf_q_z_3020();
         obf_A_M_1261();
         obf_D_T_1179();
      }
      
      internal function obf_q_z_3020() : *
      {
         try
         {
            cmdGet0["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdGet0.emphasized = false;
         cmdGet0.enabled = true;
         cmdGet0.label = "obf___4957";
         cmdGet0.labelPlacement = "right";
         cmdGet0.selected = false;
         cmdGet0.toggle = false;
         cmdGet0.visible = true;
         try
         {
            cmdGet0["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_A_M_1261() : *
      {
         try
         {
            cmdBuy1["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdBuy1.emphasized = false;
         cmdBuy1.enabled = true;
         cmdBuy1.label = "obf___4920";
         cmdBuy1.labelPlacement = "right";
         cmdBuy1.selected = false;
         cmdBuy1.toggle = false;
         cmdBuy1.visible = true;
         try
         {
            cmdBuy1["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_D_T_1179() : *
      {
         try
         {
            cmdGet1["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdGet1.emphasized = false;
         cmdGet1.enabled = true;
         cmdGet1.label = "obf___4957";
         cmdGet1.labelPlacement = "right";
         cmdGet1.selected = false;
         cmdGet1.toggle = false;
         cmdGet1.visible = true;
         try
         {
            cmdGet1["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_n_s_3351() : *
      {
         try
         {
            cmdBuy0["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdBuy0.emphasized = false;
         cmdBuy0.enabled = true;
         cmdBuy0.label = "obf___4920";
         cmdBuy0.labelPlacement = "right";
         cmdBuy0.selected = false;
         cmdBuy0.toggle = false;
         cmdBuy0.visible = true;
         try
         {
            cmdBuy0["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

