==================================================
========== FLUTTER CLEAN ARCHITECTURE ============
==================================================

feature: post
data
    - models (PostModel extends PostEntity => fromJson(), toJson())
    - datasources
    - repositories (PostRepositoryImpl => getPosts() {  }, createPost() {  })

domain (business logic)
    - entities (PostEntity: id, userId, title, body)
    - repositories (PostRepository: getPosts(), createPost()) (interface only)
    - usecases (get_post_usecase, create_post_usecase)
    
presentation
    - screens
    - widgets
    - bloc



lib/
- core/
    - networking/
    - themes/
    - errors/
    - widgets/
- features/
    - auth/
    - post/
- main.dart