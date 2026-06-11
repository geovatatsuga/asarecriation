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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3405")]
   public dynamic class PassTicketUIMC extends MovieClip
   {
      
      public var cmdAward:MainButton;
      
      public var bg:MovieClip;
      
      public var txtTitle:TextField;
      
      public var txtDay:TextField;
      
      public var txtExp:TextField;
      
      public var cmdShop:MainButton;
      
      public var awardMc:MovieClip;
      
      public var cmdClose:SimpleButton;
      
      public var cmdUpLv:MainButton;
      
      public var cmdTask:MainButton;
      
      public var txtLevel:TextField;
      
      public var expBar:MovieClip;
      
      public var obf_0_8_q_572:MovieClip;
      
      public var txtInfo:TextField;
      
      public function PassTicketUIMC()
      {
         super();
         obf_p_4_2016();
         obf_a_Z_984();
         obf_0_9_4_70();
         obf_f_R_4200();
      }
      
      internal function obf_0_9_4_70() : *
      {
         try
         {
            cmdTask["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdTask.emphasized = false;
         cmdTask.enabled = true;
         cmdTask.label = "obf___4901";
         cmdTask.labelPlacement = "right";
         cmdTask.selected = false;
         cmdTask.toggle = false;
         cmdTask.visible = true;
         try
         {
            cmdTask["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_p_4_2016() : *
      {
         try
         {
            cmdAward["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAward.emphasized = false;
         cmdAward.enabled = true;
         cmdAward.label = "obf___4884";
         cmdAward.labelPlacement = "right";
         cmdAward.selected = false;
         cmdAward.toggle = false;
         cmdAward.visible = true;
         try
         {
            cmdAward["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_f_R_4200() : *
      {
         try
         {
            cmdShop["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdShop.emphasized = false;
         cmdShop.enabled = true;
         cmdShop.label = "obf___4961";
         cmdShop.labelPlacement = "right";
         cmdShop.selected = false;
         cmdShop.toggle = false;
         cmdShop.visible = true;
         try
         {
            cmdShop["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_a_Z_984() : *
      {
         try
         {
            cmdUpLv["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdUpLv.emphasized = false;
         cmdUpLv.enabled = true;
         cmdUpLv.label = "Upgrade Pass";
         cmdUpLv.labelPlacement = "right";
         cmdUpLv.selected = false;
         cmdUpLv.toggle = false;
         cmdUpLv.visible = true;
         try
         {
            cmdUpLv["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

