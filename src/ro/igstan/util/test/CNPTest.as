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
        [Test]
        public function age1():void
        {
            var cnp:CNP = new CNP("2890729028801");
            assertThat(cnp.age, equalTo(20));
        }
        
        [Test]
        public function age2():void
        {
            var cnp:CNP = new CNP("2870313155391");
            assertThat(cnp.age, equalTo(22));
        }
        
        [Test]
        public function year1():void
        {
            var cnp:CNP = new CNP("2890729028801");
            assertThat(cnp.year, equalTo(1989));
        }
        
        [Test]
        public function year2():void
        {
            var cnp:CNP = new CNP("2870313155391");
            assertThat(cnp.year, equalTo(1987));
        }
        
        [Test]
        public function year3():void
        {
            var cnp:CNP = new CNP("5050313155391");
            assertThat(cnp.year, equalTo(2005));
        }
    }
}
