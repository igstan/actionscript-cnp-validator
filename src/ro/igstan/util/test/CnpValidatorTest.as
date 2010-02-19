package ro.igstan.util.test
{
    import org.flexunit.Assert;
    
    import ro.igstan.util.CnpValidator;
    
    
    public class CnpValidatorTest
    {
        private var cnpValidator:CnpValidator;
        
        [Before]
        public function setUp():void
        {
            this.cnpValidator = new CnpValidator();
        }
        
        [Test]
        public function rejectsCNPsNotHaving13DigitsOnly():void
        {
            Assert.assertFalse(cnpValidator.validates(""));
        }
                
        [Test]
        public function rejectsCNPsStartingWithDigit0():void
        {
            Assert.assertFalse(cnpValidator.validates("0123456789123"));
        }
        
        [Test]
        public function rejectsCNPsStartingWithDigit7():void
        {
            Assert.assertFalse(cnpValidator.validates("7123456789123"));
        }
        
        [Test]
        public function rejectsCNPsStartingWithDigit8():void
        {
            Assert.assertFalse(cnpValidator.validates("8123456789123"));
        }
        
        [Test]
        public function rejectsCNPsNotContainingAValidDate1():void
        {
            Assert.assertFalse(cnpValidator.validates("1000000789123"));
        }
        
        [Test]
        public function rejectsCNPsNotContainingAValidDate2():void
        {
            // February 31st, '84
            Assert.assertFalse(cnpValidator.validates("1840231789123"));
        }
        
        [Test]
        public function rejectsCNPsNotContainingAValidDate3():void
        {
            // April 31st, '84
            Assert.assertFalse(cnpValidator.validates("1840431789123"));
        }
        
        [Test]
        public function validatesControlDigit():void
        {
            // Original CNP was: 1850401241933.
            // The last digit (the control digit) differs.
            Assert.assertFalse(cnpValidator.validates("1850401241932"));
        }
        
        [Test]
        public function validatesCNP():void
        {
            Assert.assertTrue(cnpValidator.validates("1850401241933"));
        }
    }
}
