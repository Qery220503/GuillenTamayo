import axios from "axios";

const BASE_URL = "/";

let token = document.head.querySelector('meta[name="csrf-token"]');

const caller = axios.create({
  baseURL: BASE_URL,
  withCredentials: true,
  headers: {
    Accept: "application/json",
    "Content-Type": "application/json",
    "Access-Control-Allow-Origin": "*",
  },
});
if (localStorage.getItem("user_token")) {
  caller.defaults.headers.common["Authorization"] =
    "Bearer " + localStorage.getItem("user_token");
  console.log("ENVIANDO TOKEN: " + localStorage.getItem("user_token"));
}

caller.defaults.withCredentials = true;
caller.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest";
if (token) {
  caller.defaults.headers.common["X-CSRF-TOKEN"] = token.content;
} else {
  console.error(
    "CSRF token not found: https://laravel.com/docs/csrf#csrf-x-csrf-token"
  );
}


caller.interceptors.response.use(
  (response) => {
    return response;
  },
  (error) => {
    if (error.response.status === 401) {
      window.location.href = "/login";
      localStorage.clear();
    }
    return Promise.reject(error);
  }
);

const call = async (_type, _endpoint, _body) => {
  var _data = undefined;
  try {
    switch (_type) {
      case "get":
        _data = await caller.get(_endpoint);
        break;
      case "post":
        _data = await caller.post(_endpoint, _body);
        break;
      case "put":
        _data = await caller.put(_endpoint, _body);
        break;
      case "delete":
        _data = await caller.delete(_endpoint, _body);
        break;
      default:
        throw new Error("Not allowed method");
    }
    return _data;
  } catch (error) {
    console.log(error);
  }
};

async function callAPI(type, endpoint, options = {}) {
  try {
    var data;
    if (options.csrf_cookie) {
      await caller.get("sanctum/csrf-cookie").then(async (response) => {
        data = await call(type, endpoint, options.data);
      });
    } else {
      if (options.data) {
        options.data._token = token.content;
      }
      data = await call(type, endpoint, options.data);
    }
  } catch (error) {
    throw error;
  }
  return data;
}
export default callAPI;
