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
    public dynamic class CNP
    {
        private static const YEAR_BY_GENDER:Object = {
            1: 1900,
            2: 1900,
            3: 1800,
            4: 1800,
            5: 2000,
            6: 2000
        };
        
        private var cnp:String;
        
        private var date:Date;
        
        
        public function CNP(cnp:String, currentTime:Date = null)
        {
            this.cnp = cnp;
            this.date = date || new Date();
        }
        
        public function get age():int
        {
            var factor:int;
            
            if (currentMonth < month) {
                factor = 1;
            } else if (currentDay < day) {
                factor = 1;
            } else {
                factor = 0;
            }
            
            return currentYear - year - factor;
        }
        
        public function get year():int
        {
            var gender:String = cnp.charAt(0);
            var shortYear:int = extractIntegerPair(1, 3);
            
            return YEAR_BY_GENDER[gender] + shortYear;
        }
        
        public function get month():int
        {
            return extractIntegerPair(3, 5);
        }
        
        public function get day():int
        {
            return extractIntegerPair(5, 7);
        }
        
        protected function get currentYear():int
        {
            return date.fullYear;
        }
        
        protected function get currentMonth():int
        {
            return date.month + 1; // AS uses 0-based months
        }
        
        protected function get currentDay():int
        {
            return date.date;
        }
        
        protected function extractIntegerPair(start:int, end:int):int
        {
            return parseInt(cnp.substring(start, end), 10);
        }
    }
}
