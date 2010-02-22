/*
 * Copyright (c) 2010, Ionut Gabriel Stan. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 *    - Redistributions of source code must retain the above copyright notice,
 *      this list of conditions and the following disclaimer.
 *
 *    - Redistributions in binary form must reproduce the above copyright notice,
 *      this list of conditions and the following disclaimer in the documentation
 *      and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package ro.igstan.util
{
    /**
     * Implements the CNP validation algorithm from http://www.validari.ro/cnp.
     */
    public dynamic class CNPValidator
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
            DAYS_IN_MONTH[ JANUARY ]   = 31;
            DAYS_IN_MONTH[ MARCH ]     = 31;
            DAYS_IN_MONTH[ APRIL ]     = 30;
            DAYS_IN_MONTH[ MAY ]       = 31;
            DAYS_IN_MONTH[ JUNE ]      = 30;
            DAYS_IN_MONTH[ JULY ]      = 31;
            DAYS_IN_MONTH[ AUGUST ]    = 31;
            DAYS_IN_MONTH[ SEPTEMBER ] = 30;
            DAYS_IN_MONTH[ OCTOBER ]   = 31;
            DAYS_IN_MONTH[ NOVEMBER ]  = 30;
            DAYS_IN_MONTH[ DECEMBER ]  = 31;
        };
        
        protected static const CONTROL_DIGIT_CHECKSUM:Array = [2,7,9,1,4,6,3,5,8,2,7,9];
        
        protected var cnp:CNP;

        
        public function validates(cnp:String):Boolean
        {
            this.cnp = new CNP(cnp);
            
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
            return cnp.controlDigit === calculateControlDigit();
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
                sum += CONTROL_DIGIT_CHECKSUM[i] * cnp.digit(i);
                i++;
            }
            
            return sum;
        }
        
        protected function hasValidBirthDate(cnp:String):Boolean
        {
            return validYear() && validMonth() && validDay();
        }
        
        protected function validYear():Boolean
        {
            return cnp.birthYear > 0 && cnp.birthYear <= 99;
        }
        
        protected function validMonth():Boolean
        {
            return cnp.birthMonth > 0 && cnp.birthMonth <= 12;
        }
        
        protected function validDay():Boolean
        {
            return cnp.birthDay > 0 && cnp.birthDay <= monthLengthInDays();
        }
        
        protected function monthLengthInDays():int
        {
            return birthMonthIsFebruary()
                 ? februaryLengthInDays()
                 : regularMonthLengthInDays();
        }
        
        protected function birthMonthIsFebruary():Boolean
        {
            return cnp.birthMonth === FEBRUARY;
        }
        
        protected function februaryLengthInDays():int
        {
            return hasLeapBirthYear() ? 29 : 28;
        }
        
        protected function hasLeapBirthYear():Boolean
        {
            return  cnp.birthYear % 400 === 0
                || (cnp.birthYear % 100 !== 0 && cnp.birthYear % 4 === 0);
        }
        
        protected function regularMonthLengthInDays():int
        {
            return DAYS_IN_MONTH[cnp.birthMonth];
        }
    }
}

class CNP
{
    private var cnp:String;
    
    public function CNP(cnp:String)
    {
        this.cnp = cnp;
    }
    
    public function digit(i:int):int
    {
        return parseInt(cnp.charAt(i), 10);
    }
    
    public function get birthYear():int
    {
        return digit(1)*10 + digit(2);        
    }
    
    public function get birthMonth():int
    {
        return digit(3)*10 + digit(4);        
    }
    
    public function get birthDay():int
    {
        return digit(5)*10 + digit(6);        
    }
    
    public function get controlDigit():int
    {
        return digit(12);
    }
    
    public function toString():String
    {
        return cnp;
    }
}
