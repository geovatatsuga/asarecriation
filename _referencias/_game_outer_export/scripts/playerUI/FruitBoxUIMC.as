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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3873")]
   public dynamic class FruitBoxUIMC extends MovieClip
   {
      
      public var txtDeyGold:TextField;
      
      public var txtAllGold:TextField;
      
      public var goldFruit:MainButton;
      
      public var txtSilver:TextField;
      
      public var allNum:TextField;
      
      public var txtCopper:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var moneyFruit:MainButton;
      
      public var txtAllNum:TextField;
      
      public var txtMoney:TextField;
      
      public var moneyPoint:MovieClip;
      
      public var txtDiamond:TextField;
      
      public var bg:MovieClip;
      
      public var goldBox1:MovieClip;
      
      public var goldBox2:MovieClip;
      
      public var goldBox3:MovieClip;
      
      public var goldBox4:MovieClip;
      
      public var goldBox0:MovieClip;
      
      public var titleBox:MovieClip;
      
      public var fruitScrollBar:UIScrollBar;
      
      public var txtSay:TextField;
      
      public var cmdClose:SimpleButton;
      
      public var txtGold:TextField;
      
      public var imagePoint:MovieClip;
      
      public var buttonPoint:MovieClip;
      
      public function FruitBoxUIMC()
      {
         super();
         obf_0___y_202();
         obf_j_x_2618();
         obf_f_8_2872();
      }
      
      internal function obf_f_8_2872() : *
      {
         try
         {
            moneyFruit["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         moneyFruit.emphasized = false;
         moneyFruit.enabled = true;
         moneyFruit.label = "obf_______3924";
         moneyFruit.labelPlacement = "right";
         moneyFruit.selected = false;
         moneyFruit.toggle = false;
         moneyFruit.visible = true;
         try
         {
            moneyFruit["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0___y_202() : *
      {
         try
         {
            fruitScrollBar["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         fruitScrollBar.direction = "vertical";
         fruitScrollBar.scrollTargetName = "txtSay";
         fruitScrollBar.visible = true;
         try
         {
            fruitScrollBar["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_j_x_2618() : *
      {
         try
         {
            goldFruit["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         goldFruit.emphasized = false;
         goldFruit.enabled = true;
         goldFruit.label = "obf_______3483";
         goldFruit.labelPlacement = "right";
         goldFruit.selected = false;
         goldFruit.toggle = false;
         goldFruit.visible = true;
         try
         {
            goldFruit["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

