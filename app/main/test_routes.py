from urllib import response
import routes
import unittest


class MyTestCase(unittest.TestCase):

    def setUp(self):
        routes.app.testing = True
        self.app = routes.app.test_client()

    def test_home(self):
        result = self.app.get('/')
        # Make your assertions
        self.assertEqual(response.status_code,200) 

#   from_list_to_string(deutsch, englisch)
#   self.assertEqual(englisch)

if __name__ == '__main__':
    unittest.main()