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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2365")]
   public dynamic class RideEquStrengthUIMC extends MovieClip
   {
      
      public var txtAtt2:TextField;
      
      public var txtAtt1:TextField;
      
      public var txtAtt3:TextField;
      
      public var icon0:IconBarMC;
      
      public var icon1:IconBarMC;
      
      public var icon2:IconBarMC;
      
      public var txtEquRemark:TextField;
      
      public var txtNeedMaterial:TextField;
      
      public var equipImg:MovieClip;
      
      public var refine:MainButton;
      
      public var txtLevel:TextField;
      
      public var txtAttName:TextField;
      
      public function RideEquStrengthUIMC()
      {
         super();
         obf_8_P_3525();
      }
      
      internal function obf_8_P_3525() : *
      {
         try
         {
            refine["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         refine.emphasized = false;
         refine.enabled = true;
         refine.label = "obf_____4752";
         refine.labelPlacement = "right";
         refine.selected = false;
         refine.toggle = false;
         refine.visible = true;
         try
         {
            refine["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

