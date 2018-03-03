Simple Microblog
=============

以Ruby on Rails Tutorial的案例为基础，实现了一个简单的微博系统。

在实践过程中，对书中案例进行了许多细节上的改进，如我认为helper中应只包含用于生成视图的代码，而不应该混入其他东西，此处我使用了Concerns，还有test，不应该引入app中的业务逻辑代码。
