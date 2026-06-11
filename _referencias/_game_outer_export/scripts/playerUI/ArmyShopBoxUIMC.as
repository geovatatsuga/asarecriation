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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1231")]
   public dynamic class ArmyShopBoxUIMC extends MovieClip
   {
      
      public var cmdNextPage:MainButton;
      
      public var bg:MovieClip;
      
      public var cmdPrvPage:MainButton;
      
      public var txtDeyTitle:TextField;
      
      public var titleBox:MovieClip;
      
      public var itemPoint:MovieClip;
      
      public var cmdClose:SimpleButton;
      
      public var txtPage:TextField;
      
      public function ArmyShopBoxUIMC()
      {
         super();
         obf_0_8_T_83();
         obf_F_4191();
      }
      
      internal function obf_F_4191() : *
      {
         try
         {
            cmdPrvPage["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdPrvPage.emphasized = false;
         cmdPrvPage.enabled = true;
         cmdPrvPage.label = "obf____4858";
         cmdPrvPage.labelPlacement = "right";
         cmdPrvPage.selected = false;
         cmdPrvPage.toggle = false;
         cmdPrvPage.visible = true;
         try
         {
            cmdPrvPage["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_8_T_83() : *
      {
         try
         {
            cmdNextPage["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdNextPage.emphasized = false;
         cmdNextPage.enabled = true;
         cmdNextPage.label = "obf____4854";
         cmdNextPage.labelPlacement = "right";
         cmdNextPage.selected = false;
         cmdNextPage.toggle = false;
         cmdNextPage.visible = true;
         try
         {
            cmdNextPage["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

