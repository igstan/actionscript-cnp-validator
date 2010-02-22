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

package ro.igstan.util.test
{
    import org.flexunit.assertThat;
    import org.hamcrest.object.equalTo;
    
    import ro.igstan.util.CNP;
    
    
    public class CNPTest
    {
        private const currentDate:Date = new Date(2010, 01, 22);
        
        
        [Test]
        public function ageIsCalculatedWithMonthPrecision():void
        {
            var cnp:CNP = new CNP("2900301000000", currentDate);
            assertThat(cnp.age, equalTo(19));
        }
        
        [Test]
        public function ageIsCalculatedWithDayPrecision():void
        {
            var cnp:CNP = new CNP("2900223000000", currentDate);
            assertThat(cnp.age, equalTo(19));
        }
        
        [Test]
        public function genderDigit1MeansPersonIsBornAfter1900AndBefore1999():void
        {
            var cnp:CNP = new CNP("2890729000000");
            assertThat(cnp.year, equalTo(1989));
        }
        
        [Test]
        public function genderDigit2MeansPersonIsBornAfter1900AndBefore1999():void
        {
            var cnp:CNP = new CNP("2870313000000");
            assertThat(cnp.year, equalTo(1987));
        }
        
        [Test]
        public function genderDigit3MeansPersonIsBornAfter1800AndBefore1899():void
        {
            var cnp:CNP = new CNP("3050313000000");
            assertThat(cnp.year, equalTo(1805));
        }
        
        [Test]
        public function genderDigit4MeansPersonIsBornAfter1800AndBefore1899():void
        {
            var cnp:CNP = new CNP("4050313000000");
            assertThat(cnp.year, equalTo(1805));
        }
        
        [Test]
        public function genderDigit5MeansPersonIsBornAfter2000AndBefore2099():void
        {
            var cnp:CNP = new CNP("5050313000000");
            assertThat(cnp.year, equalTo(2005));
        }
        
        [Test]
        public function genderDigit6MeansPersonIsBornAfter2000AndBefore2099():void
        {
            var cnp:CNP = new CNP("6050313000000");
            assertThat(cnp.year, equalTo(2005));
        }
    }
}
