# NBuilder 4.0.0 Released

It's been 5 years since a version of NBuilder was released.
As happens to many of us, the original author got busy with life and was unable to spend the time brining it up to date.
I volunteered to shepherd the project along, but I was also waylaid by life. However,
I was recently able to spend some focused time fixing the final bugs and getting together an automated
build with [AppVeyor](http://link).

Given that it's been 5 years, it's impossible to know fully what has been changed. I did put
together release notes for the things I know were changed.

## Release notes

### Breaking changes


#### Obsolete methods have been removed. 

Any method previously marked with the `Obsolete` attribute has now been removed.

#### Silverlight No Longer Supported

As Silverlight is effective a dead technology, we have officially ended support for it. This will allow us to better focus on
a  forthcoming release with .NET Core support.

### New Features

#### `Builder` has a non-static implementation.

This will allow you to create customized `BuilderSettings` for different testing scenarios.

**Old Code**

```csharp
    var results = Builder<MyObject>.CreateListOfSize(10).Build();
```

**New Code**
```csharp
    var settings = new BuilderSettings()
    var results = new Builder(settings).CreateListOfSize<MyObject>(10).Build();
```

#### `With` and `Do` action now supports a signature that receives an index 

***Example***

```csharp
    var builderSettings = new BuilderSettings();
    var list = new Builder(builderSettings)
            .CreateListOfSize<MyClassWithConstructor>(10)
            .All()
            .Do((row, index) => row.Int = index*2)
            .WithConstructor(() => new MyClassWithConstructor(1, 2f))
            .Build();

```

### Bug Fixes

* The decimal separator was wrong for some cultures.
* Random number generation of decimals was sometimes incorrect.
* Sequences were not created in the correct order.
* Random strings were not always generated between the expected lengths.