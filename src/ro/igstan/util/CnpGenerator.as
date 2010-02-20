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
    public dynamic class CnpGenerator
    {
        private var isMale:Boolean = true;
        
        private var _year:String;
        
        private var month:String;
        
        
        public function generateCnp():String
        {
            return (isMale ? "1" : "2") + year + month;
        }
        
        public function male():CnpGenerator
        {
            isMale = true;
            return this;
        }
        
        public function female():CnpGenerator
        {
            isMale = false;
            return this;
        }
        
        public function birthYear(year:int):CnpGenerator
        {
            _year = year.toFixed().substring(2, 4);
            return this;
        }
        
        public function february():CnpGenerator
        {
            this.month = "02";
            return this;
        }
        
        protected function get year():String
        {
            if (_year === null) {
                _year = generateRandomYear();
            }
            
            return _year;
        }
        
        protected function generateRandomYear():String
        {
            return "87";
        }
    }
}
