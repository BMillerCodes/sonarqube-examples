"""
HTTP client for external API communication.
Code smell: Monster method with too many responsibilities
"""
import json
import time
from typing import Dict, Any, Optional, List
from urllib.request import urlopen, Request
from urllib.error import URLError, HTTPError
import logging

logger = logging.getLogger(__name__)


class HTTPClient:
    """
    HTTP client for making API requests.
    Code smell: God class with too many responsibilities
    """

    def __init__(self, base_url: str = "", api_key: str = "", timeout: int = 30):
        self.base_url = base_url
        self.api_key = api_key
        self.timeout = timeout
        self.headers: Dict[str, str] = {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
        }
        self._request_count = 0
        self._last_request_time = 0

    def set_header(self, key: str, value: str):
        """Set a custom header."""
        self.headers[key] = value

    def set_auth(self, api_key: str):
        """Set API key authentication."""
        self.api_key = api_key
        self.headers['Authorization'] = f'Bearer {api_key}'

    def request(
        self,
        method: str,
        endpoint: str,
        data: Optional[Dict] = None,
        params: Optional[Dict] = None,
        headers: Optional[Dict] = None,
        timeout: Optional[int] = None,
    ) -> Dict[str, Any]:
        """
        Make an HTTP request.
        Code smell: Monster method with too many responsibilities
        """
        # Build URL
        url = f"{self.base_url}{endpoint}"
        if params:
            query_string = '&'.join([f"{k}={v}" for k, v in params.items()])
            url = f"{url}?{query_string}"

        # Merge headers
        request_headers = self.headers.copy()
        if headers:
            request_headers.update(headers)
        if self.api_key:
            request_headers['Authorization'] = f'Bearer {self.api_key}'

        # Prepare body
        body = None
        if data:
            body = json.dumps(data).encode('utf-8')

        # Set timeout
        request_timeout = timeout or self.timeout

        # Rate limiting
        current_time = time.time()
        if current_time - self._last_request_time < 0.1:
            time.sleep(0.1 - (current_time - self._last_request_time))
        self._last_request_time = current_time
        self._request_count += 1

        # Make request
        try:
            req = Request(url, data=body, headers=request_headers, method=method)
            with urlopen(req, timeout=request_timeout) as response:
                response_body = response.read().decode('utf-8')
                if response.headers.get('Content-Type', '').startswith('application/json'):
                    return json.loads(response_body)
                return {'data': response_body}
        except HTTPError as e:
            logger.error(f"HTTP Error {e.code}: {e.reason}")
            return {'error': True, 'code': e.code, 'message': e.reason}
        except URLError as e:
            logger.error(f"URL Error: {e.reason}")
            return {'error': True, 'message': str(e.reason)}
        except Exception as e:
            logger.error(f"Unexpected error: {e}")
            return {'error': True, 'message': str(e)}

    def get(self, endpoint: str, **kwargs) -> Dict[str, Any]:
        """Make a GET request."""
        return self.request('GET', endpoint, **kwargs)

    def post(self, endpoint: str, **kwargs) -> Dict[str, Any]:
        """Make a POST request."""
        return self.request('POST', endpoint, **kwargs)

    def put(self, endpoint: str, **kwargs) -> Dict[str, Any]:
        """Make a PUT request."""
        return self.request('PUT', endpoint, **kwargs)

    def delete(self, endpoint: str, **kwargs) -> Dict[str, Any]:
        """Make a DELETE request."""
        return self.request('DELETE', endpoint, **kwargs)

    def get_stats(self) -> Dict[str, int]:
        """Get client statistics."""
        return {
            'total_requests': self._request_count,
            'last_request_time': self._last_request_time,
        }


# Global client instance
_client: Optional[HTTPClient] = None


def get_client() -> HTTPClient:
    """Get the global HTTP client instance."""
    global _client
    if _client is None:
        from config import get_config
        config = get_config()
        _client = HTTPClient(
            base_url=config.api_base_url,
            api_key=config.api_key,
            timeout=config.api_timeout,
        )
    return _client