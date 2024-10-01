const BlogPost = require('../models/BlogPost');

/**
 * Get all blog posts.
 */
exports.getAllPosts = async (req, res, next) => {
  try {
    const posts = await BlogPost.find().populate('author', 'profile.name');
    res.render('blog/index', { title: 'Blog', posts });
  } catch (err) {
    next(err);
  }
};

/**
 * Get a single blog post.
 */
exports.getPost = async (req, res, next) => {
  try {
    const post = await BlogPost.findById(req.params.id).populate('author', 'profile.name');
    if (!post) {
      return res.status(404).send('Post not found');
    }
    res.render('blog/post', { title: post.title, post });
  } catch (err) {
    next(err);
  }
};

/**
 * Create a new blog post.
 */
exports.createPost = async (req, res, next) => {
  try {
    const post = new BlogPost({
      title: req.body.title,
      content: req.body.content,
      author: req.user.id
    });
    await post.save();
    res.redirect('/blogs');
  } catch (err) {
    next(err);
  }
};

/**
 * Update a blog post.
 */
exports.updatePost = async (req, res, next) => {
  try {
    const post = await BlogPost.findById(req.params.id);
    if (!post) {
      return res.status(404).send('Post not found');
    }
    if (post.author.toString() !== req.user.id) {
      return res.status(403).send('Unauthorized');
    }
    post.title = req.body.title || post.title;
    post.content = req.body.content || post.content;
    post.updatedAt = Date.now();
    await post.save();
    res.redirect(`/blogs/${post.id}`);
  } catch (err) {
    next(err);
  }
};

/**
 * Delete a blog post.
 */
exports.deletePost = async (req, res, next) => {
  try {
    const post = await BlogPost.findById(req.params.id);
    if (!post) {
      return res.status(404).send('Post not found');
    }
    if (post.author.toString() !== req.user.id) {
      return res.status(403).send('Unauthorized');
    }
    await post.remove();
    res.redirect('/blogs');
  } catch (err) {
    next(err);
  }
};
