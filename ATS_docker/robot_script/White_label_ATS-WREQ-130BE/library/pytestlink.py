import testlink


class pytestlink(object):

    def __init__(self):
        self.tlc = None

    def open_testlink_connection(self, testlink_url, testlink_key):
        #testlink_key = '7ae4930802e9801e5887351c6d8d8700'
        #testlink_url = 'http://10.5.163.13/lib/api/xmlrpc/v1/xmlrpc.php'
        #tlc.getTestCase(None, testcaseexternalid='NO.1-6')
        #print(tlc.whatArgs('getTestCase'))

        self.tlc = testlink.TestlinkAPIClient(testlink_url, testlink_key)
        
    def upload_result_to_testlink(self, testcaseexternalid, platformid, testplanid, buildid, test_result):
        #tlc.reportTCResult(testcaseexternalid='NO.1-3', platformname='WREQ-130BE',testplanid='39', buildname='Build 0.0.1', status='p')
        self.tlc.updateTestCase(testcaseexternalid=testcaseexternalid, executiontype=2)
        if test_result == 'p':
            result = self.tlc.reportTCResult(testcaseexternalid=testcaseexternalid, platformid=platformid,testplanid=testplanid, buildid=buildid, status='p')
            return result
        else:
            result = self.tlc.reportTCResult(testcaseexternalid=testcaseexternalid, platformid=platformid,testplanid=testplanid, buildid=buildid, status='f')
            return result
        



