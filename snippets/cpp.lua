-- C++ snippets for LuaSnip
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
  -- ========== C++20/23 Concepts & Constraints ==========
  s("concept", fmt([[
template<{}>
concept {} = {};
  ]], {
    i(1, "typename T"),
    i(2, "ConceptName"),
    i(3, "requires-expression"),
  })),

  s("requires-clause", fmt([[
template<typename T>
  requires {}
{} {}({})
{{
  {}
}}
  ]], {
    i(1, "std::integral<T>"),
    i(2, "void"),
    i(3, "function_name"),
    i(4, "T value"),
    i(5, "// implementation"),
  })),

  s("requires-expr", fmt([[
requires({}) {{
  {};
  {};
}}
  ]], {
    i(1, "T t"),
    i(2, "t.member()"),
    i(3, "typename T::value_type"),
  })),

  s("template-concept", fmt([[
template<{}>
  requires {}
class {} {{
public:
  {}
private:
  {}
}};
  ]], {
    i(1, "typename T"),
    i(2, "std::is_arithmetic_v<T>"),
    i(3, "ClassName"),
    i(4, "// public members"),
    i(5, "// private members"),
  })),

  s("constrained-auto", fmt([[
{} auto {} = {};
  ]], {
    c(1, {t("std::integral"), t("std::floating_point"), t("std::derived_from<Base>")}),
    i(2, "variable"),
    i(3, "value"),
  })),

  -- ========== Template Metaprogramming ==========
  s("variadic-template", fmt([[
template<typename... Args>
{} {}(Args&&... args) {{
  {}
}}
  ]], {
    i(1, "void"),
    i(2, "function_name"),
    i(3, "(std::forward<Args>(args), ...); // fold expression"),
  })),

  s("template-spec", fmt([[
// Primary template
template<typename T>
struct {} {{
  {}
}};

// Specialization
template<>
struct {}<{}> {{
  {}
}};
  ]], {
    i(1, "TemplateName"),
    i(2, "// primary implementation"),
    rep(1),
    i(3, "int"),
    i(4, "// specialized implementation"),
  })),

  s("sfinae", fmt([[
template<typename T>
std::enable_if_t<{}, {}> {}({}) {{
  {}
}}
  ]], {
    i(1, "std::is_integral_v<T>"),
    i(2, "void"),
    i(3, "function_name"),
    i(4, "T value"),
    i(5, "// implementation"),
  })),

  s("fold-expr", fmt([[
template<typename... Args>
auto {}(Args&&... args) {{
  return ({});
}}
  ]], {
    i(1, "sum"),
    c(2, {
      t("args + ..."),
      t("... + args"),
      t("(args + ...) / sizeof...(Args)"),
    }),
  })),

  s("type-trait", fmt([[
template<typename T>
struct {} {{
  static constexpr bool value = {};
}};

template<typename T>
inline constexpr bool {}_{}_v = {}{}::value;
  ]], {
    i(1, "is_special"),
    i(2, "/* trait condition */"),
    rep(1),
    i(3, "t"),
    rep(1),
    rep(3),
  })),

  s("constexpr-if", fmt([[
if constexpr ({}) {{
  {}
}} else {{
  {}
}}
  ]], {
    i(1, "std::is_integral_v<T>"),
    i(2, "// compile-time branch"),
    i(3, "// compile-time else"),
  })),

  -- ========== Modern C++ Features ==========
  s("structured-binding", fmt([[
auto [{}, {}] = {};
  ]], {
    i(1, "first"),
    i(2, "second"),
    i(3, "std::make_pair(1, 2)"),
  })),

  s("if-init", fmt([[
if (auto {} = {}; {}) {{
  {}
}}
  ]], {
    i(1, "result"),
    i(2, "get_value()"),
    i(3, "result"),
    i(4, "// use result"),
  })),

  s("constexpr-lambda", fmt([[
constexpr auto {} = []({}) constexpr {{
  return {};
}};
  ]], {
    i(1, "lambda_name"),
    i(2, "auto x"),
    i(3, "x * 2"),
  })),

  s("generic-lambda", fmt([[
auto {} = []<typename T>(T&& {}) {{
  {}
}};
  ]], {
    i(1, "lambda"),
    i(2, "value"),
    i(3, "// generic lambda body"),
  })),

  s("coroutine", fmt([[
#include <coroutine>
#include <iostream>

struct {} {{
  struct promise_type {{
    {} get_return_object() {{ return {{}}; }}
    std::suspend_always initial_suspend() {{ return {{}}; }}
    std::suspend_always final_suspend() noexcept {{ return {{}}; }}
    void return_void() {{}}
    void unhandled_exception() {{}}
  }};
  
  bool resume() {{
    if (!handle.done()) {{
      handle.resume();
      return true;
    }}
    return false;
  }}
  
  std::coroutine_handle<promise_type> handle;
}};

{} {}() {{
  {}
  co_return;
}}
  ]], {
    i(1, "CoroutineType"),
    rep(1),
    rep(1),
    i(2, "example_coroutine"),
    i(3, "co_await std::suspend_always{};"),
  })),

  s("spaceship", fmt([[
auto operator<=>(const {}& other) const = default;
  ]], {
    i(1, "ClassName"),
  })),

  s("designated-init", fmt([[
struct {} {{
  {} {};
  {} {};
}};

auto {} = {}.{{
  .{} = {},
  .{} = {},
}};
  ]], {
    i(1, "Config"),
    i(2, "int"), i(3, "width"),
    i(4, "int"), i(5, "height"),
    i(6, "config"),
    rep(1),
    rep(3), i(7, "800"),
    rep(5), i(8, "600"),
  })),

  -- ========== Smart Pointers & Memory ==========
  s("unique_ptr", fmt([[
auto {} = std::make_unique<{}>({});
  ]], {
    i(1, "ptr"),
    i(2, "Type"),
    i(3, "args"),
  })),

  s("shared_ptr", fmt([[
auto {} = std::make_shared<{}>({});
  ]], {
    i(1, "ptr"),
    i(2, "Type"),
    i(3, "args"),
  })),

  s("weak_ptr", fmt([[
std::weak_ptr<{}> {} = {};
if (auto {} = {}.lock()) {{
  {}
}}
  ]], {
    i(1, "Type"),
    i(2, "weak"),
    i(3, "shared"),
    i(4, "shared"),
    rep(2),
    i(5, "// use shared"),
  })),

  s("custom-deleter", fmt([[
auto {} = std::unique_ptr<{}, decltype(&{})>(
  {},
  {}
);
  ]], {
    i(1, "ptr"),
    i(2, "Type"),
    i(3, "deleter_func"),
    i(4, "new Type()"),
    rep(3),
  })),

  -- ========== Containers & Algorithms ==========
  s("vector-init", fmt([[
std::vector<{}> {} = {{ {} }};
  ]], {
    i(1, "int"),
    i(2, "vec"),
    i(3, "1, 2, 3"),
  })),

  s("map-init", fmt([[
std::map<{}, {}> {} = {{
  {{ {}, {} }},
  {{ {}, {} }},
}};
  ]], {
    i(1, "KeyType"),
    i(2, "ValueType"),
    i(3, "map"),
    i(4, "key1"), i(5, "value1"),
    i(6, "key2"), i(7, "value2"),
  })),

  s("range-for", fmt([[
for (auto&& {} : {}) {{
  {}
}}
  ]], {
    i(1, "item"),
    i(2, "container"),
    i(3, "// process item"),
  })),

  s("transform", fmt([[
std::transform({}.begin(), {}.end(), {}.begin(),
  [](auto&& {}) {{
    return {};
  }}
);
  ]], {
    i(1, "source"),
    rep(1),
    i(2, "dest"),
    i(3, "x"),
    i(4, "x * 2"),
  })),

  s("views-filter", fmt([[
auto {} = {} | std::views::filter([](auto&& {}) {{
  return {};
}});
  ]], {
    i(1, "filtered"),
    i(2, "container"),
    i(3, "x"),
    i(4, "x > 0"),
  })),

  s("views-transform", fmt([[
auto {} = {} | std::views::transform([](auto&& {}) {{
  return {};
}});
  ]], {
    i(1, "transformed"),
    i(2, "container"),
    i(3, "x"),
    i(4, "x * 2"),
  })),

  s("views-pipeline", fmt([[
auto {} = {}
  | std::views::filter([](auto&& {}) {{ return {}; }})
  | std::views::transform([](auto&& {}) {{ return {}; }})
  | std::views::take({});
  ]], {
    i(1, "result"),
    i(2, "container"),
    i(3, "x"), i(4, "x > 0"),
    i(5, "y"), i(6, "y * 2"),
    i(7, "10"),
  })),

  -- ========== Concurrency ==========
  s("thread", fmt([[
std::thread {} = std::thread([]() {{
  {}
}});
{}.join();
  ]], {
    i(1, "t"),
    i(2, "// thread work"),
    rep(1),
  })),

  s("mutex", fmt([[
std::mutex {};
{{
  std::lock_guard<std::mutex> lock({});
  {}
}}
  ]], {
    i(1, "mtx"),
    rep(1),
    i(2, "// critical section"),
  })),

  s("unique-lock", fmt([[
std::unique_lock<std::mutex> {}({});
{}
{}.unlock();
  ]], {
    i(1, "lock"),
    i(2, "mtx"),
    i(3, "// critical section"),
    rep(1),
  })),

  s("condvar", fmt([[
std::condition_variable {};
std::mutex {};
bool {} = false;

// Wait
std::unique_lock<std::mutex> lock({});
{}.wait(lock, []() {{ return {}; }});

// Notify
{{
  std::lock_guard<std::mutex> lock({});
  {} = true;
}}
{}.notify_one();
  ]], {
    i(1, "cv"),
    i(2, "mtx"),
    i(3, "ready"),
    rep(2),
    rep(1),
    rep(3),
    rep(2),
    rep(3),
    rep(1),
  })),

  s("atomic", fmt([[
std::atomic<{}> {}{{ {} }};
  ]], {
    i(1, "int"),
    i(2, "counter"),
    i(3, "0"),
  })),

  s("async", fmt([[
auto {} = std::async(std::launch::{}, []() {{
  {}
  return {};
}});
auto {} = {}.get();
  ]], {
    i(1, "future"),
    c(2, {t("async"), t("deferred")}),
    i(3, "// async work"),
    i(4, "result"),
    i(5, "result"),
    rep(1),
  })),

  -- ========== Design Patterns ==========
  s("singleton", fmt([[
class {} {{
public:
  static {}& instance() {{
    static {} inst;
    return inst;
  }}

  // Delete copy/move
  {}(const {}&) = delete;
  {}& operator=(const {}&) = delete;
  {}({}&&) = delete;
  {}& operator=({}&&) = delete;

  {}

private:
  {}() = default;
  ~{}() = default;

  {}
}};
  ]], {
    i(1, "Singleton"),
    rep(1), rep(1),
    rep(1), rep(1),
    rep(1), rep(1),
    rep(1), rep(1),
    rep(1), rep(1),
    i(2, "// public interface"),
    rep(1), rep(1),
    i(3, "// private members"),
  })),

  s("factory", fmt([[
class {} {{
public:
  enum class Type {{ {} }};

  static std::unique_ptr<{}> create(Type type) {{
    switch (type) {{
      case Type::{}: return std::make_unique<{}>();
      {}
    }}
    return nullptr;
  }}

  virtual ~{}() = default;
  {}
}};
  ]], {
    i(1, "Base"),
    i(2, "TypeA, TypeB"),
    rep(1),
    i(3, "TypeA"), i(4, "DerivedA"),
    i(5, "// more cases"),
    rep(1),
    i(6, "// virtual interface"),
  })),

  s("observer", fmt([[
class Observer {{
public:
  virtual ~Observer() = default;
  virtual void update({}) = 0;
}};

class {} {{
public:
  void attach(std::shared_ptr<Observer> obs) {{
    observers_.push_back(obs);
  }}

  void notify({}) {{
    for (auto&& obs : observers_) {{
      if (auto locked = obs.lock()) {{
        locked->update({});
      }}
    }}
  }}

private:
  std::vector<std::weak_ptr<Observer>> observers_;
}};
  ]], {
    i(1, "const Event& event"),
    i(2, "Subject"),
    rep(1),
    rep(1),
  })),

  s("raii-wrapper", fmt([[
class {} {{
public:
  {}({} {}) : {}_(std::move({})) {{
    {}
  }}

  ~{}() {{
    {}
  }}

  // Delete copy, allow move
  {}(const {}&) = delete;
  {}& operator=(const {}&) = delete;
  {}({}&&) = default;
  {}& operator=({}&&) = default;

  {}

private:
  {} {}_;
}};
  ]], {
    i(1, "RAIIWrapper"),
    rep(1), i(2, "ResourceType"), i(3, "resource"),
    i(4, "resource"), rep(3),
    i(5, "// acquire"),
    rep(1),
    i(6, "// release"),
    rep(1), rep(1),
    rep(1), rep(1),
    rep(1), rep(1),
    rep(1), rep(1),
    i(7, "// interface"),
    rep(2), rep(4),
  })),

  -- ========== Class Boilerplate ==========
  s("class-rule-of-5", fmt([[
class {} {{
public:
  {}(); // Constructor
  ~{}(); // Destructor
  {}(const {}&); // Copy constructor
  {}& operator=(const {}&); // Copy assignment
  {}({}&&) noexcept; // Move constructor
  {}& operator=({}&&) noexcept; // Move assignment

  {}

private:
  {}
}};
  ]], {
    i(1, "ClassName"),
    rep(1),
    rep(1),
    rep(1), rep(1),
    rep(1), rep(1),
    rep(1), rep(1),
    rep(1), rep(1),
    i(2, "// public interface"),
    i(3, "// private members"),
  })),

  s("move-ctor", fmt([[
{}({}&& other) noexcept
  : {}(std::move(other.{}))
{{
  {}
}}
  ]], {
    i(1, "ClassName"),
    rep(1),
    i(2, "member_"),
    rep(2),
    i(3, "// additional move logic"),
  })),

  s("copy-ctor", fmt([[
{}(const {}& other)
  : {}(other.{})
{{
  {}
}}
  ]], {
    i(1, "ClassName"),
    rep(1),
    i(2, "member_"),
    rep(2),
    i(3, "// additional copy logic"),
  })),

  s("operator==", fmt([[
bool operator==(const {}& other) const {{
  return {} == other.{};
}}
  ]], {
    i(1, "ClassName"),
    i(2, "member_"),
    rep(2),
  })),

  s("operator<<", fmt([[
friend std::ostream& operator<<(std::ostream& os, const {}& obj) {{
  return os << {};
}}
  ]], {
    i(1, "ClassName"),
    i(2, "obj.member_"),
  })),

  -- ========== Error Handling ==========
  s("try-catch", fmt([[
try {{
  {}
}} catch (const {}& e) {{
  {}
}}
  ]], {
    i(1, "// code that may throw"),
    c(2, {t("std::exception"), t("std::runtime_error"), t("...")}),
    i(3, "std::cerr << e.what() << '\\n';"),
  })),

  s("exception-class", fmt([[
class {} : public std::runtime_error {{
public:
  explicit {}(const std::string& message)
    : std::runtime_error(message) {{}}
  
  {}
}};
  ]], {
    i(1, "CustomException"),
    rep(1),
    i(2, "// additional members"),
  })),

  s("noexcept-func", fmt([[
{} {}({}) noexcept {{
  {}
}}
  ]], {
    i(1, "void"),
    i(2, "function_name"),
    i(3, "/* params */"),
    i(4, "// implementation"),
  })),

  -- ========== Google Test Snippets ==========
  s("test-fixture", fmt([[
class {} : public ::testing::Test {{
protected:
  void SetUp() override {{
    {}
  }}

  void TearDown() override {{
    {}
  }}

  {}
}};

TEST_F({}, {}) {{
  {}
}}
  ]], {
    i(1, "TestFixture"),
    i(2, "// setup"),
    i(3, "// teardown"),
    i(4, "// test members"),
    rep(1),
    i(5, "TestName"),
    i(6, "// test body"),
  })),

  s("test", fmt([[
TEST({}, {}) {{
  {}
}}
  ]], {
    i(1, "TestSuite"),
    i(2, "TestName"),
    i(3, "ASSERT_TRUE(true);"),
  })),

  s("assert-eq", t("ASSERT_EQ(expected, actual);")),
  s("expect-eq", t("EXPECT_EQ(expected, actual);")),
  s("assert-true", t("ASSERT_TRUE(condition);")),
  s("expect-throw", fmt("EXPECT_THROW({}, {});", {i(1, "func()"), i(2, "std::exception")})),

  s("mock-class", fmt([[
class {} : public {} {{
public:
  MOCK_METHOD({}, {}, ({}), ({}));
  {}
}};
  ]], {
    i(1, "MockClass"),
    i(2, "BaseClass"),
    i(3, "ReturnType"),
    i(4, "method_name"),
    i(5, "ParamTypes"),
    c(6, {t("override"), t("const override"), t("noexcept override")}),
    i(7, "// more mocks"),
  })),
}
