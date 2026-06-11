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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol5124")]
   public dynamic class AngelCeilUIMC extends MovieClip
   {
      
      public var iconBar:IconBarMC;
      
      public var bg:MovieClip;
      
      public var cmdCall:MainButton;
      
      public var txtName:TextField;
      
      public var txtValueExplain:TextField;
      
      public function AngelCeilUIMC()
      {
         super();
         obf_a_c_2609();
      }
      
      internal function obf_a_c_2609() : *
      {
         try
         {
            cmdCall["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdCall.emphasized = false;
         cmdCall.enabled = true;
         cmdCall.label = "obf___4895/obf___4946";
         cmdCall.labelPlacement = "right";
         cmdCall.selected = false;
         cmdCall.toggle = false;
         cmdCall.visible = true;
         try
         {
            cmdCall["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

