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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol963")]
   public dynamic class FamilyViewUIMC extends MovieClip
   {
      
      public var cmdJoin:MainButton;
      
      public var txtDeyFamilyRes2:TextField;
      
      public var txtDeyFamilyIntroduction:TextField;
      
      public var txtFamilyExp:TextField;
      
      public var bgBox:MovieClip;
      
      public var pointGold:MovieClip;
      
      public var txtDeyFamilyGold:TextField;
      
      public var txtMemberNumber:TextField;
      
      public var txtFamilyLeader:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var txtFamilyName:TextField;
      
      public var txtDeyFamilyLevel:TextField;
      
      public var txtRes2:TextField;
      
      public var txtDeyMemberNumber:TextField;
      
      public var txtFamilyIntroduction:TextField;
      
      public var txtDeyFamilyExp:TextField;
      
      public var txtDeyFamilyLeader:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var txtFamilyLevel:TextField;
      
      public function FamilyViewUIMC()
      {
         super();
         obf_0_2_4_658();
      }
      
      internal function obf_0_2_4_658() : *
      {
         try
         {
            cmdJoin["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdJoin.emphasized = false;
         cmdJoin.enabled = true;
         cmdJoin.label = "obf_____4764";
         cmdJoin.labelPlacement = "right";
         cmdJoin.selected = false;
         cmdJoin.toggle = false;
         cmdJoin.visible = true;
         try
         {
            cmdJoin["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

