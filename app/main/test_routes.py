import utils

import unittest

class MyTestCase(unittest.TestCase):

    def setUp(self):
        utils.app.testing = True
        self.app = utils.app.test_client()

    def test_home(self):
        result = self.app.get('/')
        # Make your assertions
        self.assertTrue(result, '/')

if __name__ == '__main__':
    unittest.main()