package ro.igstan.util
{
    public dynamic class CnpValidator
    {
        protected static const JANUARY:int   = 1;
        protected static const FEBRUARY:int  = 2;
        protected static const MARCH:int     = 3;
        protected static const APRIL:int     = 4;
        protected static const MAY:int       = 5;
        protected static const JUNE:int      = 6;
        protected static const JULY:int      = 7;
        protected static const AUGUST:int    = 8;
        protected static const SEPTEMBER:int = 9;
        protected static const OCTOBER:int   = 10;
        protected static const NOVEMBER:int  = 11;
        protected static const DECEMBER:int  = 12;
        
        protected static const DAYS_IN_MONTH:Object = {};
        
        {
            DAYS_IN_MONTH[JANUARY]   = 31;
            DAYS_IN_MONTH[MARCH]     = 31;
            DAYS_IN_MONTH[APRIL]     = 30;
            DAYS_IN_MONTH[MAY]       = 31;
            DAYS_IN_MONTH[JUNE]      = 30;
            DAYS_IN_MONTH[JULY]      = 31;
            DAYS_IN_MONTH[AUGUST]    = 31;
            DAYS_IN_MONTH[SEPTEMBER] = 30;
            DAYS_IN_MONTH[OCTOBER]   = 31;
            DAYS_IN_MONTH[NOVEMBER]  = 30;
            DAYS_IN_MONTH[DECEMBER]  = 31;
        };
        
        protected static const CONTROL_DIGIT_CHECKSUM:Array = [2,7,9,1,4,6,3,5,8,2,7,9];
        
        protected var cnp:String;

        
        public function validates(cnp:String):Boolean
        {
            this.cnp = cnp;
            
            return hasThirteenDigits(cnp)
                && hasValidBirthDate(cnp)
                && hasValidControlDigit();
        }
        
        protected function hasThirteenDigits(cnp:String):Boolean
        {
            return /^[1234569][0-9]{12}$/.test(cnp);
        }
        
        protected function hasValidControlDigit():Boolean
        {
            var controlDigit:int = extractControlDigit();
            var computedControlDigit:int = calculateControlDigit();
            
            return computedControlDigit === controlDigit;
        }
        
        protected function calculateControlDigit():int
        {
            var controlSum:int = calculateControlSum();
            var controlDigit:int = controlSum % 11;
            
            return controlDigit < 10 ? controlDigit : 1;
        }
        
        protected function calculateControlSum():int
        {
            var sum:int = 0;
            var i:int   = 0;
            
            while (i < 12) {
                sum += CONTROL_DIGIT_CHECKSUM[i] * getCnpDigit(i);
                i++;
            }
            
            return sum;
        }
        
        protected function extractControlDigit():int
        {
            return getCnpDigit(12);
        }
        
        protected function hasValidBirthDate(cnp:String):Boolean
        {
            return validYear() && validMonth() && validDay();
        }
        
        protected function validYear():Boolean
        {
            return birthYear > 0 && birthYear <= 99;
        }
        
        protected function validMonth():Boolean
        {
            return birthMonth > 0 && birthMonth <= 12;
        }
        
        protected function validDay():Boolean
        {
            return birthDay > 0 && birthDay <= monthLengthInDays();
        }
        
        protected function monthLengthInDays():int
        {
            return birthMonthIsFebruary()
                 ? februaryLengthInDays()
                 : regularMonthLengthInDays();
        }
        
        protected function birthMonthIsFebruary():Boolean
        {
            return birthMonth === FEBRUARY;
        }
        
        protected function februaryLengthInDays():int
        {
            return isLeapBirthYear() ? 29 : 28;
        }
        
        protected function isLeapBirthYear():Boolean
        {
            return  birthYear % 400 === 0
                || (birthYear % 100 !== 0 && birthYear % 4 === 0);
        }
        
        protected function regularMonthLengthInDays():int
        {
            return DAYS_IN_MONTH[birthMonth];
        }
        
        protected function get birthYear():int
        {
            return extractBirthDatePart(1, 3);
        }
        
        protected function get birthMonth():int
        {
            return extractBirthDatePart(3, 5);
        }
        
        protected function get birthDay():int
        {
            return extractBirthDatePart(5, 7);
        }
        
        protected function extractBirthDatePart(start:int, end:int):int
        {
            return parseInt(cnp.substring(start, end), 10);
        }
        
        protected function getCnpDigit(i:int):int
        {
            return parseInt(cnp.charAt(i), 10);
        }
    }
}
