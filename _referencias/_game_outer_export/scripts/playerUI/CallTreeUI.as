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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5214")]
   public dynamic class CallTreeUI extends MovieClip
   {
      
      public var cmdMoney:MainButton;
      
      public function CallTreeUI()
      {
         super();
         obf_Q_e_4280();
      }
      
      internal function obf_Q_e_4280() : *
      {
         try
         {
            cmdMoney["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdMoney.emphasized = false;
         cmdMoney.enabled = true;
         cmdMoney.label = "obf_______3242";
         cmdMoney.labelPlacement = "right";
         cmdMoney.selected = false;
         cmdMoney.toggle = false;
         cmdMoney.visible = true;
         try
         {
            cmdMoney["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

