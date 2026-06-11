package obf_h_e_3633
{
   public class IncubatorItem
   {
      
      public var itemCode:String;
      
      public var obf_Z_O_1926:int = 0;
      
      public var maxTimes:int;
      
      public var attr:Object;
      
      public var rank:int;
      
      public function IncubatorItem(param1:IncubatorItemConfig)
      {
         super();
         this.itemCode = param1.itemCode;
         this.maxTimes = param1.maxTimes;
         this.attr = param1.attr;
         this.rank = param1.rank;
      }
   }
}

