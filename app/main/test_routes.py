import routes

import unittest

class MyTestCase(unittest.TestCase):

    def setUp(self):
        routes.app.testing = True
        self.app = routes.app.test_client()

    def test_home(self):
        result = self.app.get('/')
        # Make your assertions
        self.assertTrue(result, '/')

if __name__ == '__main__':
    unittest.main()